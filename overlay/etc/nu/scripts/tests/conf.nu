use std/assert
use ../bf-wordpress/conf.nu *


#======================================================================================================================
# helpers
#======================================================================================================================

# Generate wp-config.php from the template in a temporary directory, the way 'conf generate' does (including escaping
# the database values), and return the path - $vars are added to (and override) the defaults
def render [vars: record = {}]: nothing -> string {
    let file = $"(mktemp --directory)/wp-config.php"
    let defaults = {
        BF_WP_DB_NAME: "wordpress"
        BF_WP_DB_USER: "wp_user"
        BF_WP_DB_PASS: "secret"
        BF_WP_DB_HOST: "db"
        SALT: "define( 'AUTH_KEY', 'test-salt' );"
    }
    with-env ($defaults | merge $vars) {
        let escaped = [WP_DB_NAME WP_DB_USER WP_DB_PASS WP_DB_HOST]
            | reduce --fold {} {|x, acc| $acc | insert $"BF_($x)" ($env | get $"BF_($x)" | php_escape) }
        with-env $escaped { ^esh -o $file /etc/bf/templates/wp-config.php.esh }
    }
    $file
}

# Return the value PHP sees for constant $name in a generated wp-config.php (only the database defines are evaluated)
def php_constant [file: string, name: string]: nothing -> string {
    let defines = open --raw $file | lines | where {|x| $x | str starts-with "define( 'DB_" } | str join "\n"
    let php = $"<?php\n($defines)\necho ($name);"
    let tmp = mktemp
    $php | save --force $tmp
    let result = ^php $tmp | complete
    rm --force $tmp
    $result.stdout
}


#======================================================================================================================
# php_escape
#======================================================================================================================

export def php_escape__escapes_quotes_and_backslashes [] {
    assert equal "it\\'s" ("it's" | php_escape)
    assert equal "back\\\\slash" ("back\\slash" | php_escape)
    assert equal "plain $value \"text\"" ("plain $value \"text\"" | php_escape) "only quotes and backslashes are special in single-quoted PHP strings"
}


#======================================================================================================================
# wp-config.php template
#======================================================================================================================

export def template__generates_valid_php [] {
    let file = render
    let result = ^php -l $file | complete
    rm --recursive --force ($file | path dirname)

    assert equal 0 $result.exit_code $"wp-config.php is not valid PHP: ($result.stdout)($result.stderr)"
}

export def template__password_with_quotes_and_backslashes__is_kept_exactly [] {
    let password = "it's a \\ test'\\"
    let file = render {BF_WP_DB_PASS: $password}
    let lint = ^php -l $file | complete
    let result = php_constant $file "DB_PASSWORD"
    rm --recursive --force ($file | path dirname)

    assert equal 0 $lint.exit_code "wp-config.php should still be valid PHP"
    assert equal $password $result "PHP should see exactly the password that was set"
}

export def template__optional_blocks__follow_environment_variables [] {
    let on = render {BF_WP_ENABLE_HTTPS_BEHIND_PROXY: "1", BF_WP_USE_SYSTEM_CRON: "1", BF_WP_DISABLE_MAJOR_UPDATES: "1", BF_WP_REDIS_HOST: "redis", BF_WP_CONFIG_ADDITIONAL: "define( 'BF_TEST', true );"}
    let off = render {BF_WP_ENABLE_HTTPS_BEHIND_PROXY: "0", BF_WP_USE_SYSTEM_CRON: "0", BF_WP_DISABLE_MAJOR_UPDATES: "0"}
    let on_conf = open --raw $on
    let off_conf = open --raw $off
    rm --recursive --force ($on | path dirname) ($off | path dirname)

    assert ($on_conf | str contains "HTTP_X_FORWARDED_PROTO") "HTTPS behind proxy block should be added"
    assert ($on_conf | str contains "define( 'DISABLE_WP_CRON', true );") "system cron block should be added"
    assert ($on_conf | str contains "define( 'WP_AUTO_UPDATE_CORE', 'minor' );") "minor updates block should be added"
    assert ($on_conf | str contains "define( 'WP_REDIS_HOST', 'redis' );") "Redis host should be added"
    assert ($on_conf | str contains "define( 'BF_TEST', true );") "additional configuration should be added"

    assert not ($off_conf | str contains "HTTP_X_FORWARDED_PROTO") "HTTPS behind proxy block should not be added"
    assert not ($off_conf | str contains "DISABLE_WP_CRON") "system cron block should not be added"
    assert not ($off_conf | str contains "WP_AUTO_UPDATE_CORE") "minor updates block should not be added"
    assert not ($off_conf | str contains "WP_REDIS_HOST") "Redis host should not be added"
}


#======================================================================================================================
# get_salt
#======================================================================================================================

export def get_salt__file_exists__returns_it_without_downloading [] {
    # keeping the same salt is what keeps everyone logged in across restarts
    let file = mktemp
    "define( 'AUTH_KEY', 'kept' );" | save --force $file

    let result = with-env {BF_WP_SALT: $file} { get_salt }
    rm --force $file

    assert equal "define( 'AUTH_KEY', 'kept' );" ($result | str trim)
}

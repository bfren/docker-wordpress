use std/assert
use bf

const src = "/etc/bf/src/wordpress"


#======================================================================================================================
# installation
#======================================================================================================================

export def install__source_is_read_only_and_owned_by_www [] {
    assert equal "www:www 500" (^stat -c "%U:%G %a" $src | str trim) "the source directory should be read-only"
    assert equal "www:www 400" (^stat -c "%U:%G %a" $"($src)/wp-login.php" | str trim) "source files should be read-only"
}

export def install__wordpress_version_matches_build [] {
    let expected = with-env {BF_ETC: "/etc/bf"} { bf build | get WordPress }
    let installed = open --raw $"($src)/wp-includes/version.php" | parse --regex "\\$wp_version = '(?<v>[^']+)';" | get v.0

    assert equal $expected $installed
}

export def install__plugin_versions_are_stored [] {
    for name in [WP_PLUGIN_NINJAFIREWALL_VERSION WP_PLUGIN_WP-WEBAUTHN_VERSION] {
        let file = $"/etc/bf/env.d/BF_($name)"
        assert ($file | path exists) $"($name) should be stored"
        assert ((open --raw $file | str trim) =~ '^[0-9]+(\.[0-9]+)+$') $"($name) should be a version number"
    }
}

export def install__required_extensions_are_loaded [] {
    let modules = ^php -m | lines | str trim | str lowercase
    let required = [curl dom exif fileinfo gd intl mbstring mysqli openssl xml zip]

    for x in $required { assert ($x in $modules) $"the ($x) extension should be loaded" }

    # Imagick and Redis are only installed on PHP 8
    if (^php -r "echo PHP_MAJOR_VERSION;") == "8" {
        for x in [imagick redis] { assert ($x in $modules) $"the ($x) extension should be loaded" }
    }
}


#======================================================================================================================
# nginx
#======================================================================================================================

export def nginx__wordpress_site_is_valid [] {
    # test a copy, as tests run in parallel
    let dir = mktemp --directory
    ^cp -a /etc/nginx/. $dir
    let result = ^nginx -t -c $"($dir)/nginx.conf" | complete
    rm --recursive --force $dir

    assert equal 0 $result.exit_code $"nginx -t failed: ($result.stderr)"
}

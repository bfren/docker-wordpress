use bf
use perms.nu
use bf-s6

# Generate wp-config.php file
export def generate [] {
    # ensure all required environment variables are set
    check WP_DB_HOST
    check WP_DB_NAME
    check WP_DB_USER
    check WP_DB_PASS

    # get authentication salt values
    $env.SALT = (get_salt)

    # generate configuration file - the database values are escaped while the template is generated, because they are
    # put inside single-quoted PHP strings, so a quote or backslash in (e.g.) a password would otherwise break the file
    let wp_config = bf env WP_CONFIG
    bf write $"Generating ($wp_config)." conf/generate
    let escaped = [WP_DB_NAME WP_DB_USER WP_DB_PASS WP_DB_HOST]
        | reduce --fold {} {|x, acc| $acc | insert $"BF_($x)" (bf env $x | php_escape) }
    with-env $escaped { bf-s6 esh template $wp_config }

    # set permissions
    perms set_config
}

# Escape a value so it can be used inside a single-quoted PHP string - backslashes and single quotes are the only
# characters with special meaning there
export def php_escape []: string -> string {
    $in
        | str replace --all '\' '\\'
        | str replace --all "'" "\\'"
}

# Check that a required environment variable exists and is not empty
def check [
    key: string         # Environment variable key - the BF_ prefix will be added automatically
] {
    if (bf env empty $key) { bf write error $"You must define ($key)." conf/check }
}

# Return authentication salt values - downloading them from the WordPress API if they do not
# already exist, or $force is enabled
export def get_salt [
    --force (-f)    # Get salt even if it already exists (warning: there will be consequences!)
] {
    # get salt file
    let file = bf env WP_SALT

    # if force flag is enabled, remove the salt file first
    if $force { rm --force $file }

    # if the salt file does not exist, use WP api to download fresh salt values
    if ($file | bf fs is_not_file) {
        let url = "https://api.wordpress.org/secret-key/1.1/salt/"
        bf write $"Downloading fresh authentication secrets from ($url)." conf/get_salt
        bf http download $url $file
    } else {
        bf write $"Reading authentication secrets from ($file)." conf/get_salt
    }

    # read salt file contents and return
    bf fs read $file
}

use bf

# Generate wp-config.php file
export def generate [] {
    # ensure all required environment variables are set
    check WP_DB_HOST
    check WP_DB_NAME
    check WP_DB_USER
    check WP_DB_PASS

    # get authentication salt values
    $env.SALT = (get_salt)

    # generate configuration file
    let wp_config = bf env WP_CONFIG
    bf write debug $"Generating ($wp_config)." conf/generate
    bf esh template $wp_config

    # set permissions (write access is required by some plugins, e.g. caching / optimise plugins)
    let mode = if (bf env check WP_CONFIG_HARDEN) { 0400 } else { 0600 }
    bf ch --owner "www:www" --mode $mode $wp_config
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
    if $force { rm -f $file }

    # if the salt file does not exist, use WP api to download fresh salt values
    if ($file | bf fs is_not_file) {
        let url = "https://api.wordpress.org/secret-key/1.1/salt/"
        bf write $"Downloading authentication secrets from ($url)." conf/get_salt
        http get --raw $url | save $file
    }

    # read salt file contents and return
    bf fs read $file
}

use bf

# User / group for permissions
const user = "www:www"

# Set permissions on /wp-content files and directories
export def set_content [] {
    # set permissions for directory
    bf write $"Setting wp-content permissions." perms/content
    [(bf env WP_CONTENT) $user "0644" "0755"] | bf ch apply

    # wp-config.php has more restrictive permissions
    set_config
}

# Set permissions on wp-config.php file
export def set_config [] {
    # set permissions (write access is required by some plugins, e.g. caching / optimise plugins)
    bf write $"Setting wp-config.php permissions." perms/config
    let mode = if (bf env check WP_CONFIG_HARDEN) { 0400 } else { 0600 }
    [(bf env WP_CONFIG) $user $mode] | bf ch apply
}

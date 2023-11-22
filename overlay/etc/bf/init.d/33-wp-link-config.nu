use bf
use bf-wordpress
bf env load

def main [] {
    # get variables
    let wp_config = bf env WP_CONFIG
    let wp_config_src = bf env WP_CONFIG_SRC

    # ensure the wp-config.php file exists
    if ($wp_config | bf fs is_not_file) { bf write error $"($wp_config) does not exist." }

    # link wp-config.php to source directory so WordPress can access it
    ^ln -fs $wp_config $wp_config_src
}

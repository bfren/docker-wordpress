use bf
use bf-wordpress
bf env load

def main [] {
    # get variables
    let wp_content = bf env WP_CONTENT
    let wp_content_src = bf env WP_CONTENT_SRC

    # if the wp-content src directory is not linked to /wp-content, the setup has gone wrong
    if ($wp_content_src | bf fs is_not_symlink) { bf write error $"($wp_content_src) is not linked to ($wp_content)." }

    # if using a custom wp-config.php file and it already exists, do nothing
    if (bf env test WP_CONFIG_REGENERATE 0) and (bf env WP_CONFIG | path exists) {
        bf write "Using custom wp-config.php."
        return
    }

    # generate wp-config.php file
    bf-wordpress conf generate
}

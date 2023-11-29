use bf
bf env load

# Set environment variables
def main [] {
    let wp_src = bf env WP_SRC
    bf env set WP_CONFIG_SRC $"($wp_src)/wp-config.php"
    bf env set WP_USER_INI $"($wp_src)/.user.ini"

    let wp_content = "/wp-content"
    bf env set WP_CONTENT $wp_content
    bf env set WP_CONFIG $"($wp_content)/wp-config.php"
    bf env set WP_SALT $"($wp_content)/salt"

    let wp_content_src = $"($wp_src)($wp_content)"
    bf env set WP_CONTENT_SRC $wp_content_src
    bf env set WP_CONTENT_DEFAULT $"($wp_content_src)-default"

    let wp_content_languages = $"($wp_content)/languages"
    bf env set WP_LANGUAGES $wp_content_languages

    let wp_content_plugins = $"($wp_content)/plugins"
    bf env set WP_PLUGINS $wp_content_plugins

    let wp_content_themes = $"($wp_content)/themes"
    bf env set WP_THEMES $wp_content_themes

    let wp_content_uploads = $"($wp_content)/uploads"
    bf env set WP_UPLOADS $wp_content_uploads
}

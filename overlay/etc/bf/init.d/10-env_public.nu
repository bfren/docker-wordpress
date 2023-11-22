use bf
bf env load

# Override Nginx public environment variable to point to WordPress source
def main [] {
    let wp_src = $"(bf env ETC_SRC)/wordpress"
    bf env set WP_SRC $wp_src
    bf env set NGINX_PUBLIC $wp_src
}

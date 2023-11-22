use bf
use bf-wordpress
bf env load

def main [] {
    # get variables
    let wp_config_src = bf env WP_CONFIG_SRC
    let firewall = bf env WP_FIREWALL
    let user_ini = bf env WP_USER_INI

    # ensure the wp-config.php file exists as a symlink in the src directory
    if ($wp_config_src | bf fs is_not_symlink) { bf write error $"($wp_config_src) does not exist." }

    # if Ninja Firewall is enabled, install and set it up
    if (bf env check WP_INSTALL_NINJAFIREWALL) {
        # install plugin
        bf-wordpress plugin install_ninjafirewall

        # generate files for full WAF mode
        bf esh template $firewall
        bf esh template $user_ini
    }

    # WordPress setup is complete
    bf env set WP_SETUP_COMPLETE 1
}

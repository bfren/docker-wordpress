use bf

# Install a plugin
def install [
    name: string
    ref: string
] {
    # get version
    let version = bf env $"WP_PLUGIN_($ref | str upcase)_VERSION"

    # get path to plugins directory
    let wp_src = bf env WP_SRC
    let plugins_dir = $"($wp_src)/wp-content/plugins"

    # get path to plugin directory
    let plugin_dir = $"($plugins_dir)/($ref)"

    # if the plugin directory exists, return - otherwise, make it
    if ($plugin_dir | path exists) {
        bf write $"Plugin ($name) is already installed." plugin/install
        return
    } else {
        bf write $"Installing plugin ($name)." plugin/install
        mkdir $plugin_dir
    }

    # get URL to download plugin
    let url = $"https://downloads.wordpress.org/plugin/($ref).($version).zip"
    bf write debug $" .. downloading from url: ($url)" plugin/install

    # download plugin
    cd /tmp
    let name = $plugin_dir | path split | last
    let tmp = $"/tmp/($name)"
    let zip = $"($name).zip"
    bf http download $url $zip

    # unzip files
    bf write debug $" .. unzipping source download files to ($tmp)" plugin/install
    ^unzip -oq $zip
    rm $zip
    if ($tmp | bf fs is_not_dir) { bf write error $" .. not downloaded." plugin/install }

    # move files to plugin directory
    bf write debug $" .. moving source files to ($plugin_dir)" plugin/install
    rm --force --recursive $plugin_dir
    mv $tmp $plugin_dir
    if ($plugin_dir | bf fs is_not_dir) { bf write error $" .. not installed" plugin/install }
}

# Install Ninja Firewall
export def install_ninjafirewall [] {
    # install plugin
    install "Ninja Firewall" "ninjafirewall"

    # create cache directory
    mkdir $"(bf env WP_CONTENT)/nfwlog/cache"
}

# Install Web Authn
export def install_webauthn [] {
    # install plugin
    install "WP-WebAuthn" "wp-webauthn"
}

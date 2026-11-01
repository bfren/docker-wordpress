use bf

# Install a plugin
def install [
    name: string
    ref: string
] {
    # get version
    let version = bf env $"WP_PLUGIN_($ref | str uppercase)_VERSION"

    # get path to plugins directory
    let wp_src = bf env WP_SRC
    let plugins_dir = $"($wp_src)/wp-content/plugins"

    # get path to plugin directory
    let plugin_dir = $"($plugins_dir)/($ref)"

    # if the plugin is installed, return - the directory is only created by moving the downloaded files into place
    if ($plugin_dir | is_installed) {
        bf write $"Plugin ($name) is already installed." plugin/install
        return
    }
    bf write $"Installing plugin ($name)." plugin/install

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

# Returns true if the plugin directory exists and has files - earlier versions left an empty one after a failed
# download, which must not count as installed
export def is_installed []: string -> bool {
    let dir = $in
    ($dir | path exists) and (ls $dir | is-not-empty)
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

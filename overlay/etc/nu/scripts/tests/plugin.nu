use std/assert
use ../bf-wordpress/plugin.nu


#======================================================================================================================
# is_installed
#======================================================================================================================

export def is_installed__only_when_plugin_directory_has_files [] {
    let dir = mktemp --directory
    let plugin = $"($dir)/ninjafirewall"
    assert not ($plugin | plugin is_installed) "a missing directory is not installed"

    # an empty directory is left by a failed download in earlier versions
    mkdir $plugin
    assert not ($plugin | plugin is_installed) "an empty directory is not installed"

    "<?php" | save $"($plugin)/ninjafirewall.php"
    assert ($plugin | plugin is_installed)
}

use std/assert
use ../bf-wordpress/perms.nu *


#======================================================================================================================
# set_config
#======================================================================================================================

# Run set_config on a temporary wp-config.php with BF_WP_CONFIG_HARDEN set to $harden, and return its owner and mode
def config_perms [harden: string]: nothing -> string {
    let file = mktemp
    "<?php" | save --force $file
    with-env {BF_WP_CONFIG: $file, BF_WP_CONFIG_HARDEN: $harden} { set_config }
    let result = ^stat -c "%U:%G %a" $file | str trim
    rm --force $file
    $result
}

export def set_config__harden__makes_config_read_only [] {
    assert equal "www:www 400" (config_perms "1")
}

export def set_config__do_not_harden__makes_config_writable [] {
    assert equal "www:www 600" (config_perms "0")
}

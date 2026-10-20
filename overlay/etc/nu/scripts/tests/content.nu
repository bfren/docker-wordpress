use std/assert
use ../bf-wordpress/content.nu *


#======================================================================================================================
# recreate
#======================================================================================================================

export def recreate__replaces_content_with_default [] {
    let root = mktemp --directory
    let content = $"($root)/wp-content"
    let default = $"($root)/wp-content-default"
    mkdir $content $"($default)/themes" $"($default)/plugins"
    "old" | save $"($content)/old.txt"
    "<?php" | save $"($default)/index.php"
    "<?php" | save $"($root)/wp-config.php"

    let vars = {BF_WP_CONTENT: $content, BF_WP_CONTENT_DEFAULT: $default, BF_WP_CONFIG: $"($root)/wp-config.php"}
    with-env $vars { recreate }
    let result = ls $content | get name | path basename | sort
    let owner = ^stat -c "%U:%G" $content | str trim
    rm --recursive --force $root

    assert equal ["index.php" "plugins" "themes"] $result "content should be replaced by the default content"
    assert equal "www:www" $owner "content should be owned by www"
}

use bf
use perms.nu

# Recreate wp-content directory using default content
export def recreate [] {
    # get directories as variables for easy access
    let content = bf env WP_CONTENT
    let default = bf env WP_CONTENT_DEFAULT

    # delete contents first
    if (ls $content | length) > 0 { rm -rf $"($content)/*" }

    # copy default wp-content
    bf write $"Copying default wp-content to ($default)." content/recreate
    cp -r $"($default)/*" $content

    # set correct permissions
    perms set
}

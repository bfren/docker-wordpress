use bf
use bf-wordpress
bf env load

def main [] {
    # get variables
    let wp_content = bf env WP_CONTENT
    let wp_content_src = bf env WP_CONTENT_SRC

    # ensure source files exist
    if (bf env WP_SRC | bf fs is_not_dir) { bf write error "WordPress source files cannot be found." }

    # if content directory is empty, setup default content
    if (ls $wp_content | length) == 0 {
        setup_default
    } else {
        bf write $"($wp_content) has content."
        if (bf env debug) { ls $wp_content | print }
    }

    # link source wp-content to /wp-content
    if ($wp_content_src | path type) == "dir" {
        link_directories
    } else {
        bf write $"($wp_content_src) is already linked to ($wp_content)."
    }
}

# Set up wp-content directory with default contents
def setup_default [] {
    bf write "Setting up default wp-content directory." setup_default

    # get variables
    let wp_content = bf env WP_CONTENT
    let wp_content_src = bf env WP_CONTENT_SRC

    # if source wp-content is already a link, recreate /wp-content using the default copy
    let wp_content_src = bf env WP_CONTENT_SRC
    if ($wp_content_src | path type) == "symlink" {
        bf-wordpress content recreate
        return
    }

    # otherwise, move source wp-content to mapped directory
    bf write $"Moving ($wp_content_src) files and directories." setup_default
    ls --full-paths $wp_content_src | get name | each {|x|
        # get file name
        let filename = $x | path basename
        bf write $" .. ($filename)" setup_default

        # define new content variable
        let in_wp = $"($wp_content)/($filename)"
        bf write debug $"    moving ($x) to ($in_wp)" setup_default

        # move content
        mv $x $wp_content
    }
}

# Link src wp-content directory to /wp-content
def link_directories [] {
    # get variables
    let wp_content = bf env WP_CONTENT
    let wp_content_src = bf env WP_CONTENT_SRC

    bf write $"Deleting ($wp_content_src) so it can be turned into a symlink." link_directories
    rm -rf $wp_content_src

    bf write $"Linking ($wp_content_src) to ($wp_content)." link_directories
    ^ln -s $wp_content $wp_content_src
    bf ch --owner "www:www" $wp_content_src
}

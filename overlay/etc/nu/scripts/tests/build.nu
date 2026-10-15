use std/assert
use ../bf-wordpress/build.nu


#======================================================================================================================
# arg
#======================================================================================================================

# Run 'build arg' in a temporary directory containing a WP_VERSION file, with $value as the build argument (if set)
def arg_with [value?: string]: nothing -> string {
    let dir = mktemp --directory
    "7.1.3" | save $"($dir)/WP_VERSION"
    let vars = if ($value == null) { {} } else { {WP_VERSION: $value} }
    let result = with-env $vars { cd $dir ; build arg WP_VERSION }
    rm --recursive --force $dir
    $result
}

export def arg__build_argument_set__returns_build_argument [] {
    assert equal "6.9.1" (arg_with "6.9.1")
}

export def arg__build_argument_empty__returns_file_contents [] {
    # 'ARG WP_VERSION=' in the Dockerfile sets an empty variable when no build argument is passed
    assert equal "7.1.3" (arg_with "")
}

export def arg__build_argument_not_set__returns_file_contents [] {
    # /test runs with an empty environment, so WP_VERSION is not set
    assert equal "7.1.3" (arg_with)
}

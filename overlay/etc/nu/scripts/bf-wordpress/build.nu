use bf

# Get a value from the build argument $name if it is set (Docker makes build arguments available as environment variables
# while the image is built), otherwise read it from the file of the same name in the current directory (/tmp)
export def arg [
    name: string    # The build argument / file name, e.g. WP_VERSION
]: nothing -> string {
    let value = $env | get --optional $name | default "" | str trim
    if ($value | is-empty) { return (bf fs read $name) }

    bf write $"Using ($name) build argument: ($value)." build/arg
    $value
}

use bf

# Set permissions using ch.d file
export def set [] {
    let file = $"(bf env ETC_CH_D)/30-wp"
    bf write debug $"Setting permissions using ($file)." perms/set
    bf ch apply_file $file
}

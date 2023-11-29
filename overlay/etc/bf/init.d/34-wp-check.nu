use bf
use bf-s6
use bf-wordpress
bf env load

def main [] {
    # if setup is complete, set permissions and write OK message
    if (bf env check WP_SETUP_COMPLETE) {
        # set correct permissions
        bf-wordpress perms set_content

        # remove any temporary files used during setup
        bf clean

        # output ok message and exit
        bf write ok "WordPress setup complete."
        exit 0
    }

    # otherwise, terminate the container
    bf write notok "WordPress setup did not complete successfully, terminating container."
    bf-s6 cont terminate
}

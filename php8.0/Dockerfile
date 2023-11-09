FROM bfren/nginx-php:php8.0-7.0.0-dev

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-wordpress"

ARG BF_IMAGE
ARG BF_VERSION

ARG \
    # set to a valid WordPress version or the installation will fail
    # if empty, will use value in /overlay/tmp/WP_VERSION
    WP_VERSION= \
    # set to a valid WordPress locale or the installation will fail
    # if empty, will use value in /overlay/tmp/WP_LOCALE
    WP_LOCALE=

COPY ./overlay /
COPY ./php8.0/overlay /

ENV \
    # options for config file permissions:
    #  - 0 (generate if it does not exist, and make it writeable by web server user)
    #  - 1 (default: generate if it does not exist, and make it readonly to web server user)
    WP_CONFIG_HARDEN=1 \
    # set to 0 to re-enable WordPress core updates - otherwise they will be handled by the image
    WP_DISABLE_MAJOR_UPDATES=1 \
    # whether or not to enable HTTPS behind a proxy server
    WP_ENABLE_HTTPS_BEHIND_PROXY=1 \
    # set to 0 if you don't want the NinjaFirewall plugin to be installed automatically and setup
    # to run in full WAF mode (you will still have to enable it in the WordPress backend)
    WP_INSTALL_NINJAFIREWALL=1 \
    # set to 0 to use WordPress cron instead of system cron (will reduce performance)
    # you must remove define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    WP_USE_SYSTEM_CRON=1

RUN bf-install

VOLUME [ "/wp-content" ]

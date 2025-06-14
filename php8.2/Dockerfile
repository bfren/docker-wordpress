FROM ghcr.io/bfren/nginx-php:php8.2.28-7.4.1

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-wordpress"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

ARG \
    # set to a valid WordPress version or the installation will fail
    # if empty, will use value in /overlay/tmp/WP_VERSION
    WP_VERSION= \
    # set to a valid WordPress locale or the installation will fail
    # if empty, will use value in /overlay/tmp/WP_LOCALE
    WP_LOCALE=

COPY ./overlay /
COPY ./php8.2/overlay /

ENV \
    # load the WordPress login page for healthcheck
    BF_NGINX_HEALTHCHECK_URI=http://localhost/wp-login.php \
    # options for config file permissions:
    #  - 0 (make it writeable by web server user)
    #  - 1 (make it readonly to web server user)
    BF_WP_CONFIG_HARDEN=1 \
    # options for config file generation:
    #  - 0 (generate on container startup if it does not exist)
    #  - 1 (always regenerate on container startup)
    BF_WP_CONFIG_REGENERATE=1 \
    # set to 0 to re-enable WordPress core updates - otherwise they will be handled by the image
    BF_WP_DISABLE_MAJOR_UPDATES=1 \
    # whether or not to enable HTTPS behind a proxy server
    BF_WP_ENABLE_HTTPS_BEHIND_PROXY=1 \
    # set to 1 if you want the NinjaFirewall plugin to be setup to run in full WAF mode
    # (you will still have to enable it in the WordPress backend)
    # NB: this must be 0 until you have installed WordPress or you will not be able to access the site
    BF_WP_INSTALL_NINJAFIREWALL=0 \
    # set to 0 if you don't want the WebAuthn plugin to be installed automatically
    BF_WP_INSTALL_WEBAUTHN=1 \
    # set to 0 to use WordPress cron instead of system cron (will reduce performance)
    # you must remove define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    BF_WP_USE_SYSTEM_CRON=1

RUN bf-install

VOLUME [ "/wp-content" ]

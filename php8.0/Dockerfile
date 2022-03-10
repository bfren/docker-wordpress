FROM bfren/nginx-php:php8.0-4.2.0

ARG BF_IMAGE
ARG BF_VERSION

ARG \
    # set to a valid WordPress version or the installation will fail
    # if empty, will use value in text file WP_VERSION
    WP_VERSION="" \
    # set to a valid WordPress locale or the installation will fail
    # if empty, will use value in text file WP_LOCALE
    WP_LOCALE=""

ENV \
    # set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!)
    WP_CLEAN_INSTALL=0 \
    # additional directives to be added to wp-config.php
    WP_CONFIG_ADDITIONAL= \
    # database name
    WP_DB_NAME= \
    # database user
    WP_DB_USER= \
    # database password
    WP_DB_PASS= \
    # database host
    WP_DB_HOST= \
    # database character set
    WP_DB_CHARSET="utf8mb4" \
    # database collation
    WP_DB_COLLATE= \
    # database prefix
    WP_DB_PREFIX="wp" \
    # whether or not to enable debug mode
    WP_DEBUG="false" \
    # whether or not to enable HTTPS behind a proxy server
    WP_ENABLE_HTTPS_BEHIND_PROXY=1 \
    # set to 0 to re-enable WordPress core updates - otherwise they will be handled by the image
    WP_DISABLE_MAJOR_UPDATES=1 \
    # set to 1 to use system cron instead of WordPress cron (improves page performance)
    # you must add define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    WP_USE_SYSTEM_CRON=1

COPY ./overlay /
COPY ./WP_VERSION /tmp/
COPY ./WP_LOCALE /tmp/

COPY ./php8.0/overlay /

RUN bf-install

VOLUME [ "/wp-content" ]

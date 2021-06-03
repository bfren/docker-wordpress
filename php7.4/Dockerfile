FROM bcgdesign/nginx-php:php7.4-2.1.6

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="7.4" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG \
    # set to a valid WordPress locale or the installation will fail
    WP_LOCALE="en_GB"

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
COPY ./WP_VERSION /tmp/WP_VERSION

COPY ./php7.4/overlay /
COPY ./php7.4/PHP_BUILD /tmp/PHP_VERSION
COPY ./php7.4/IMAGICK_BUILD /tmp/IMAGICK_VERSION

RUN bcg-install

VOLUME [ "/wp-content" ]

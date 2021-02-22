FROM bcgdesign/nginx-php:php-7.3-2.0.1

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="7.3" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ENV \
    # set to a valid WordPress locale or the installation will fail
    WP_LOCALE="en_GB" \
    # set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!)
    WP_CLEAN_INSTALL=0 \
    # set to 1 to generate wp-config.php based on environment variables
    WP_GENERATE_CONFIG=1 \
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
    # set to 0 to use WordPress cron instead of system cron (reduces site performance)
    WP_USE_SYSTEM_CRON=1

COPY ./overlay /
COPY ./7.3/overlay /
COPY ./7.3/PHP_BUILD /tmp/PHP_VERSION
COPY ./7.3/IMAGICK_BUILD /tmp/IMAGICK_VERSION

RUN bcg-install

VOLUME [ "/wp" ]

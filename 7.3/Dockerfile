FROM bcgdesign/nginx-php:php-7.3-1.3.2

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="7.3" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION=7.3.27-r0
ARG GOMPLATE_VERSION=3.7.0-r0
ARG IMAGICK_VERSION=3.4.4-r4

RUN apk -U upgrade \
    && apk add \
        curl \
        gomplate=${GOMPLATE_VERSION} \
        unzip \
        php7-cgi=${PHP_VERSION} \
        php7-ctype=${PHP_VERSION} \
        php7-curl=${PHP_VERSION} \
        php7-dom=${PHP_VERSION} \
        php7-exif=${PHP_VERSION} \
        php7-fileinfo=${PHP_VERSION} \
        php7-ftp=${PHP_VERSION} \
        php7-gd=${PHP_VERSION} \
        php7-gettext=${PHP_VERSION} \
        php7-iconv=${PHP_VERSION} \
        php7-imap=${PHP_VERSION} \
        php7-json=${PHP_VERSION} \
        php7-mbstring=${PHP_VERSION} \
        php7-mysqli=${PHP_VERSION} \
        php7-sodium=${PHP_VERSION} \
        php7-openssl=${PHP_VERSION} \
        php7-simplexml=${PHP_VERSION} \
        php7-soap=${PHP_VERSION} \
        php7-sockets=${PHP_VERSION} \
        php7-xml=${PHP_VERSION} \
        php7-xmlrpc=${PHP_VERSION} \
        php7-xmlreader=${PHP_VERSION} \
        php7-zip=${PHP_VERSION} \
        php7-pecl-imagick=${IMAGICK_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

ENV \
    # set to a valid WordPress locale or the installation will fail
    LOCALE="en_GB" \
    # set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!)
    CLEAN_INSTALL=0 \
    # set to 1 to generate wp-config.php based on environment variables
    GENERATE_CONFIG=1 \
    # database name
    WPDB_NAME= \
    # database user
    WPDB_USER= \
    # database password
    WPDB_PASS= \
    # database host
    WPDB_HOST= \
    # database character set
    WPDB_CHARSET="utf8mb4" \
    # database collation
    WPDB_COLLATE= \
    # database prefix
    WPDB_PREFIX="wp" \
    # whether or not to enable debug mode
    DEBUG="false" \
    # whether or not to enable HTTPS behind a proxy server
    ENABLE_HTTPS_BEHIND_PROXY=1 \
    # set to 1 to use system cron instead of WordPress cron (improves page performance)
    # you must add define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    USE_SYSTEM_CRON=1

COPY ./overlay /

VOLUME [ "/wp" ]

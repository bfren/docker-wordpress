FROM bcgdesign/nginx-php:php-8.0-1.3.1

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="8.0" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION=8.0.2-r0
ARG GOMPLATE_VERSION=3.8.0-r0
ARG IMAGICK_VERSION=3.4.4-r0

RUN apk -U upgrade \
    && apk add \
        curl \
        gomplate=${GOMPLATE_VERSION} \
        unzip \
        php8-cgi=${PHP_VERSION} \
        php8-ctype=${PHP_VERSION} \
        php8-curl=${PHP_VERSION} \
        php8-dom=${PHP_VERSION} \
        php8-exif=${PHP_VERSION} \
        php8-fileinfo=${PHP_VERSION} \
        php8-ftp=${PHP_VERSION} \
        php8-gd=${PHP_VERSION} \
        php8-gettext=${PHP_VERSION} \
        php8-iconv=${PHP_VERSION} \
        php8-imap=${PHP_VERSION} \
        php8-mbstring=${PHP_VERSION} \
        php8-mysqlnd=${PHP_VERSION} \
        php8-mysqli=${PHP_VERSION} \
        php8-sodium=${PHP_VERSION} \
        php8-openssl=${PHP_VERSION} \
        php8-simplexml=${PHP_VERSION} \
        php8-soap=${PHP_VERSION} \
        php8-sockets=${PHP_VERSION} \
        php8-xml=${PHP_VERSION} \
        php8-xmlreader=${PHP_VERSION} \
        php8-zip=${PHP_VERSION} \
        php8-pecl-imagick=${IMAGICK_VERSION} \
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

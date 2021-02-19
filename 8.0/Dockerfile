FROM bcgdesign/nginx-php:php-8.0-1.5.0

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="8.0" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION=8.0.2-r0
ARG IMAGICK_VERSION=3.4.4-r0

RUN apk -U upgrade \
    && apk add \
        curl \
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
    # set to 1 to use system cron instead of WordPress cron (improves page performance)
    # you must add define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    WP_USE_SYSTEM_CRON=1

COPY ./overlay /
COPY ./8.0/PHP_BUILD /tmp/PHP_VERSION
COPY ./8.0/IMAGICK_BUILD /tmp/IMAGICK_VERSION

RUN bcg-install

VOLUME [ "/wp" ]

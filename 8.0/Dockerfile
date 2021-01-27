ARG PHP_VERSION=8.0.1-r0
FROM bcgdesign/nginx-php:php-${PHP_VERSION}

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="edge" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION
ARG IMAGICK_VERSION=3.4.4-r0

RUN apk -U upgrade \
    && apk add \
        curl \
        unzip \
        php8-cgi@edgecomm=${PHP_VERSION} \
        php8-ctype@edgecomm=${PHP_VERSION} \
        php8-curl@edgecomm=${PHP_VERSION} \
        php8-dom@edgecomm=${PHP_VERSION} \
        php8-exif@edgecomm=${PHP_VERSION} \
        php8-fileinfo@edgecomm=${PHP_VERSION} \
        php8-ftp@edgecomm=${PHP_VERSION} \
        php8-gd@edgecomm=${PHP_VERSION} \
        php8-gettext@edgecomm=${PHP_VERSION} \
        php8-iconv@edgecomm=${PHP_VERSION} \
        php8-imap@edgecomm=${PHP_VERSION} \
        #php8-json@edgecomm=${PHP_VERSION} \
        php8-mbstring@edgecomm=${PHP_VERSION} \
        php8-mysqlnd@edgecomm=${PHP_VERSION} \
        php8-mysqli@edgecomm=${PHP_VERSION} \
        php8-sodium@edgecomm=${PHP_VERSION} \
        php8-openssl@edgecomm=${PHP_VERSION} \
        php8-simplexml@edgecomm=${PHP_VERSION} \
        php8-soap@edgecomm=${PHP_VERSION} \
        php8-sockets@edgecomm=${PHP_VERSION} \
        php8-xml@edgecomm=${PHP_VERSION} \
        #php8-xmlrpc@edgecomm=${PHP_VERSION} \
        php8-xmlreader@edgecomm=${PHP_VERSION} \
        php8-zip@edgecomm=${PHP_VERSION} \
        php8-pecl-imagick@edgecomm=${IMAGICK_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

ENV \
    # set to a valid WordPress locale or the installation will fail
    WORDPRESS_LOCALE="en_GB" \
    # set to 1 to wipe WordPress files and start again (WARNING: YOU WILL LOSE EVERYTHING!)
    WORDPRESS_CLEAN_INSTALL=0 \
    # set to 1 to use system cron instead of WordPress cron (improves page performance)
    # you must add define('DISABLE_WP_CRON', true); to wp-config.php to make a difference
    USE_SYSTEM_CRON=0

COPY ./overlay /

VOLUME [ "/wp" ]

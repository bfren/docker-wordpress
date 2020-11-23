ARG PHP_VERSION=7.4.12-r1
FROM bcgdesign/nginx-php:${PHP_VERSION}

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION
ARG IMAGICK_VERSION=3.4.4-r3

RUN apk -U upgrade \
    && apk add \
        unzip \
        php7-cgi@edgecomm=${PHP_VERSION} \
        php7-ctype@edgecomm=${PHP_VERSION} \
        php7-curl@edgecomm=${PHP_VERSION} \
        php7-dom@edgecomm=${PHP_VERSION} \
        php7-exif@edgecomm=${PHP_VERSION} \
        php7-fileinfo@edgecomm=${PHP_VERSION} \
        php7-ftp@edgecomm=${PHP_VERSION} \
        php7-gd@edgecomm=${PHP_VERSION} \
        php7-gettext@edgecomm=${PHP_VERSION} \
        php7-iconv@edgecomm=${PHP_VERSION} \
        php7-imap@edgecomm=${PHP_VERSION} \
        php7-json@edgecomm=${PHP_VERSION} \
        php7-mbstring@edgecomm=${PHP_VERSION} \
        php7-mysqli@edgecomm=${PHP_VERSION} \
        php7-sodium@edgecomm=${PHP_VERSION} \
        php7-openssl@edgecomm=${PHP_VERSION} \
        php7-simplexml@edgecomm=${PHP_VERSION} \
        php7-soap@edgecomm=${PHP_VERSION} \
        php7-sockets@edgecomm=${PHP_VERSION} \
        php7-xml@edgecomm=${PHP_VERSION} \
        php7-xmlrpc@edgecomm=${PHP_VERSION} \
        php7-xmlreader@edgecomm=${PHP_VERSION} \
        php7-zip@edgecomm=${PHP_VERSION} \
        php7-pecl-imagick=${IMAGICK_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

ENV WORDPRESS_LOCALE="en_GB" \
    WORDPRESS_CLEAN_INSTALL=0

COPY ./overlay /

VOLUME [ "/wp" ]

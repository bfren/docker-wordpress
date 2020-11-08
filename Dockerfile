ARG PHP_VERSION=7.4.12
FROM bcgdesign/nginx-php:${PHP_VERSION}

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="WordPress" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG PHP_VERSION

RUN apk update \
    && apk upgrade \
    && apk add \
        php7-curl=${PHP_VERSION} \
        php7-dom=${PHP_VERSION} \
        php7-exif=${PHP_VERSION} \
        php7-fileinfo=${PHP_VERSION} \
        php7-ftp=${PHP_VERSION} \
        php7-gd=${PHP_VERSION} \
        php7-hash=${PHP_VERSION} \
        php7-iconv=${PHP_VERSION} \
        php7-json=${PHP_VERSION} \
        php7-mbstring=${PHP_VERSION} \
        php7-mcrypt=${PHP_VERSION} \
        php7-mysqlnd=${PHP_VERSION} \
        php7-sodium=${PHP_VERSION} \
        php7-openssl=${PHP_VERSION} \
        php7-pcre=${PHP_VERSION} \
        php7-simplexml=${PHP_VERSION} \
        php7-sockets=${PHP_VERSION} \
        php7-xml=${PHP_VERSION} \
        php7-xmlreader=${PHP_VERSION} \
        php7-zip=${PHP_VERSION} \
        php7-zlib=${PHP_VERSION} \
    && rm -rf /var/cache/apk/*

ENV WORDPRESS_LOCALE="en_GB"

COPY ./VERSION /tmp/VERSION
RUN export WORDPRESS_VERSION=$(cat /tmp/VERSION)

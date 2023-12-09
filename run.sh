#!/bin/sh

IMAGE=`cat VERSION`
PHP=${1:-php8.3}

docker buildx build \
    --load \
    --no-cache \
    --progress plain \
    --build-arg BF_IMAGE=wordpress \
    --build-arg BF_VERSION=${IMAGE} \
    -f ${PHP}/Dockerfile \
    -t wordpress${PHP}-dev \
    . \
    && \
    docker run -it \
        -e BF_DEBUG=1 \
        -e BF_WP_DB_HOST=test \
        -e BF_WP_DB_NAME=test \
        -e BF_WP_DB_USER=test \
        -e BF_WP_DB_PASS=test \
        wordpress${PHP}-dev \
        sh

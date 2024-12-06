#!/bin/sh

IMAGE=wordpress
VERSION=`cat VERSION`
PHP=${1:-8.4}
TAG=${IMAGE}-test

docker buildx build \
    --load \
    --build-arg BF_IMAGE=${IMAGE} \
    --build-arg BF_VERSION=${VERSION} \
    -f php${PHP}/Dockerfile \
    -t ${TAG} \
    . \
    && \
    docker run --entrypoint /test ${TAG}

#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="7.1.2"
echo "Base: ${BASE_VERSION}"

PHP_VERSIONS="7.4 8.0 8.1 8.2 8.3"
for V in ${PHP_VERSIONS} ; do

    echo "WordPress for PHP ${V}"

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        PHP_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./php${V}/Dockerfile

done

docker system prune -f
echo "Done."

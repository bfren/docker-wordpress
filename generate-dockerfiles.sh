#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_VERSION="7.3.4"
echo "Base: ${BASE_VERSION}"

PHP_VERSIONS="7.4 8.0 8.1 8.2 8.3 8.4"
for V in ${PHP_VERSIONS} ; do

    echo "WordPress for PHP ${V}"
    PHP_REVISION=`cat php${V}/PHP_REVISION`

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_VERSION=${BASE_VERSION} \
        PHP_MINOR=${V} \
        PHP_REVISION=${PHP_REVISION}
    )

    echo "${DOCKERFILE}" > ./php${V}/Dockerfile

done

docker system prune -f
echo "Done."

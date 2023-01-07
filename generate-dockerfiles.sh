#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="5.3.16"
echo "Base: ${BASE_REVISION}"

PHP_VERSIONS="7.4 8.0 8.1 8.2"
for V in ${PHP_VERSIONS} ; do

    echo "FreeScout for PHP ${V}"

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        -e BF_DEBUG=0 \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        PHP_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./php${V}/Dockerfile

done

docker system prune -f
echo "Done."

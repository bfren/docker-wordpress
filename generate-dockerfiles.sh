#!/bin/bash

set -euo pipefail

docker pull bfren/alpine

BASE_REVISION="3.2.2"
echo "Base: ${BASE_REVISION}"

PHP_VERSIONS="7.3 7.4 8.0"
for V in ${PHP_VERSIONS} ; do

    echo "WordPress for PHP ${V}"

    DOCKERFILE=$(docker run \
        -v ${PWD}:/ws \
        bfren/alpine esh \
        "/ws/Dockerfile.esh" \
        BASE_REVISION=${BASE_REVISION} \
        PHP_MINOR=${V}
    )

    echo "${DOCKERFILE}" > ./php${V}/Dockerfile

done

docker system prune -f
echo "Done."

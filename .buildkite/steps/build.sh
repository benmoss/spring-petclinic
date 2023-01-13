#!/bin/bash

set -euxo pipefail

./gradlew test jib --image ttl.sh/spring-petclinic:1h

digest=$(cat ./build/jib-image.digest)
buildkite-agent meta-data set "image" "ttl.sh/spring-petclinic@${digest}"

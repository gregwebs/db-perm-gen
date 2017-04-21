#!/usr/bin/env bash
set -euo pipefail

ENV_VARIABLES=$(env | egrep '^BISCUIT_|^AWS_' | awk '{print "--env " $1}' | xargs echo || echo "")
DOCKER_WORKDIR=${DOCKER_WORKDIR:-"$PWD"}

{
    if ! docker images | grep db-perm-gen ; then
      pushd "$( dirname "$0" )"
      ./build.sh
      popd
    fi
} >/dev/null

exec docker run --rm -it $ENV_VARIABLES \
    -v "$PWD:$PWD" -w "$DOCKER_WORKDIR" \
    -v "$HOME/.aws:/root/.aws:ro" \
    db-perm-gen "$@"

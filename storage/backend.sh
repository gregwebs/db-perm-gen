#!/bin/bash
set -euo pipefail

BACKEND="$1"
shift

case "$BACKEND" in
    biscuit)
        ;;
    plain-text)
        ;;
    *)
      echo "expected biscuit or plain-text" >&2
      echo "did not understand backend: $BACKEND" >&2
      exit 1
      ;;
esac

DIR="$( dirname "$0" )"
"$DIR/$BACKEND.sh" "$@" > /dev/null

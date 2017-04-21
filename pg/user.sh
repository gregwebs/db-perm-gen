#!/bin/bash
set -euo pipefail

BACKEND="$1"
shift

ROLE="$1"
shift
USER="$1"
shift
PASSWORD=$(pwgen -s -1 20)

DIR="$( dirname "$0" )"
"$DIR/user-password-sql.sh" "$ROLE" "$USER" "$PASSWORD"
"$DIR/../storage/backend.sh" "$BACKEND" "$USER" "$PASSWORD" "$@" > /dev/null

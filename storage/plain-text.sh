#!/bin/bash
set -euo pipefail

DB_USER="$1"
PASSWORD="$2"
FILE="$3"

if [[ ! -f "$FILE" ]] ; then
    echo "FILE not found: $FILE" >&2
    exit 1
fi

echo "$DB_USER $PASSWORD" >> "$FILE"

#!/bin/bash
set -euo pipefail

if [[ -z ${BISCUIT_LABEL+undefined-guard} ]] ; then
  echo "BISCUIT_LABEL is unset" >&2
  exit 1
fi

DB_USER="$1"
PASSWORD="$2"
FILE="$3"
AWS_USER="$4"

if [[ ! -f "$FILE" ]] ; then
    echo "FILE not found: $FILE" >&2
    exit 1
fi

needs_grant=
if ! biscuit get -f "$FILE" -- "$DB_USER" >/dev/null 2>&1 ; then
  needs_grant=true
fi

biscuit put -f "$FILE" -- "$DB_USER" "$PASSWORD"

if [[ $needs_grant == true ]]; then
  biscuit kms grants create --grantee-principal "user/$AWS_USER" -f "$FILE" "$DB_USER"
fi

#!/bin/bash
set -euo pipefail

ROLE="$1"
USER="$2"
PASSWORD="$3"
HASH=$( echo -n "${PASSWORD}${USER}" | md5sum | awk '{print $1}' )

echo "DROP USER IF EXISTS $USER ;"
echo "CREATE USER $USER WITH PASSWORD 'md5$HASH' ;"
echo "GRANT $ROLE TO $USER ;"

#!/bin/bash
set -euo pipefail

ROLE="$1"
USER="$2"
PASSWORD="$3"
HASH=$( echo -n "${PASSWORD}${USER}" | md5sum | awk '{print $1}' )

cat <<SQL
IF NOT EXISTS (SELECT * FROM pg_catalog.pg_roles WHERE rolname = '$USER')
THEN
  CREATE USER $USER WITH PASSWORD 'md5$HASH' ;
ELSE
  ALTER USER $USER PASSWORD 'md5$HASH' ;
END IF ;
GRANT $ROLE TO $USER ;
SQL

#!/bin/bash
set -euo pipefail

ROLE="$1"
SCHEMA="${2:-public}"

cat <<SQL
IF
EXISTS (SELECT * FROM pg_catalog.pg_roles WHERE rolname = '$ROLE')

THEN
    REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA     $SCHEMA FROM $ROLE ;
    REVOKE ALL PRIVILEGES ON ALL TABLES    IN SCHEMA     $SCHEMA FROM $ROLE ;
    REVOKE ALL PRIVILEGES ON SCHEMA                      $SCHEMA FROM $ROLE ;
    REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA     $SCHEMA FROM $ROLE ;

    ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA REVOKE ALL PRIVILEGES ON TABLES FROM $ROLE ;
    ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA REVOKE ALL PRIVILEGES ON SEQUENCES FROM $ROLE ;
    ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA REVOKE ALL PRIVILEGES ON FUNCTIONS FROM $ROLE ;
ELSE
    CREATE ROLE $ROLE;

END IF ;

GRANT USAGE         ON                  SCHEMA     $SCHEMA TO $ROLE ;
GRANT SELECT        ON ALL TABLES    IN SCHEMA     $SCHEMA TO $ROLE ;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA     $SCHEMA TO $ROLE ;
GRANT EXECUTE       ON ALL FUNCTIONS IN SCHEMA     $SCHEMA TO $ROLE ;

ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA GRANT SELECT         ON TABLES    TO $ROLE;
ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA GRANT USAGE, SELECT  ON SEQUENCES TO $ROLE;
ALTER DEFAULT PRIVILEGES IN SCHEMA $SCHEMA GRANT EXECUTE        ON FUNCTIONS TO $ROLE;
SQL

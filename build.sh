#!/bin/bash
set -euo pipefail

cd "$( dirname "$0" )"

docker build -t db-perm-gen .

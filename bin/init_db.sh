#!/usr/bin/env bash
set -eu

[[ -f secrets/env ]] && source secrets/env

# Authenticate with wp-stateless account to ensure we can pull from SQL bucket
gcloud auth activate-service-account --key-file secrets/stateless-service-account.json

gsutil cp "gs://${CONTENT_BUCKET}/${CONTENT_SQLDUMP}.gz" . && gunzip -k -f "${CONTENT_SQLDUMP}.gz"

################################################################################

CLOUDSQL_ENV=develop MYSQL_ROOT_PASSWORD=${MYSQL_DEVELOPMENT_ROOT_PASSWORD} create_mysql_user_database.sh

################################################################################

CLOUDSQL_ENV=release MYSQL_ROOT_PASSWORD=${MYSQL_PRODUCTION_ROOT_PASSWORD} create_mysql_user_database.sh

################################################################################

CLOUDSQL_ENV=master MYSQL_ROOT_PASSWORD=${MYSQL_PRODUCTION_ROOT_PASSWORD} create_mysql_user_database.sh

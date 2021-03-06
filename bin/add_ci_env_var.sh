#!/usr/bin/env bash
# shellcheck disable=SC2016
set -eu

key=${1}
value=${2}

echo "Key:     ${key}"

json=$(jq -n --arg key "$key" --arg value "$value" '{ name: $key, value: $value }')

curl -u "${CIRCLE_TOKEN}:" -X POST --header "Content-Type: application/json" -d "$json" \
  "https://circleci.com/api/v1.1/project/${VCS_TYPE:-github}/${CIRCLE_PROJECT_USERNAME:-greenpeace}/${GITHUB_REPOSITORY_NAME}/envvar"

echo

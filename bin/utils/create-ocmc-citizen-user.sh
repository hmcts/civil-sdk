#!/bin/bash

set -e

USER_EMAIL="${1:-me@server.net}"
ENV="${2:-local}"
FORENAME="${3:-John}"
SURNAME="${4:-Smith}"
PASSWORD=Password12
USER_GROUP="citizens"
USER_ROLES='[{"code":"citizen"}]'

binFolder=$(dirname "$0")

${binFolder}/create-user.sh "${USER_EMAIL}" "${ENV}" "${FORENAME}" "${SURNAME}" "${USER_ROLES}"


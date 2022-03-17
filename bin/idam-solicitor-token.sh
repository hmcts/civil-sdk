#!/bin/sh

IMPORTER_USERNAME=${1:-test@example.com}
IMPORTER_PASSWORD=${2:-Password12!}
IDAM_OPEN_ID_URI=http://localhost:5000/o/token
CLIENT_ID="am_role_assignment"
CLIENT_SECRET="am_docker_secret"
GRANT_TYPE="password"
SCOPE_VARIABLES=openid%20profile%20roles%20authorities%20create-user%20manage-user%20search-user

curl ${CURL_OPTS} -H "Content-Type: application/x-www-form-urlencoded" -XPOST "${IDAM_OPEN_ID_URI}?client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&grant_type=${GRANT_TYPE}&scope=${SCOPE_VARIABLES}&username=${IMPORTER_USERNAME}&password=${IMPORTER_PASSWORD}" -d "" | jq -r .access_token
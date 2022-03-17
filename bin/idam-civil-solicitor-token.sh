#!/bin/sh

IMPORTER_USERNAME=${1:-hmcts.civil+organisation.1.solicitor.1@gmail.com}
IMPORTER_PASSWORD=${2:-Password12!}
IDAM_OPEN_ID_URI=http://localhost:5000/o/token
CLIENT_ID="civil"
CLIENT_SECRET="OOOOOOOOOOOOOOOO"
GRANT_TYPE="password"
SCOPE_VARIABLES=openid%20profile%20authorities%20acr%20roles%20search-user%20openid%20profile%20roles

curl ${CURL_OPTS} -H "Content-Type: application/x-www-form-urlencoded" -XPOST "${IDAM_OPEN_ID_URI}?client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&grant_type=${GRANT_TYPE}&scope=${SCOPE_VARIABLES}&username=${IMPORTER_USERNAME}&password=${IMPORTER_PASSWORD}" -d "" | jq -r .access_token

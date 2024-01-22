#!/bin/bash

set -e

USER_EMAIL="${1:-me@server.net}"
ENV="${2:-local}"
FORENAME="${3:-John}"
SURNAME="${4:-Smith}"
PASSWORD=Password12
USER_ROLES="${5:-[]}"

case ${ENV} in
  local)
    IDAM_URI="http://localhost:5000"
  ;;
  saat|sprod)
    IDAM_URI="http://betadevbccidamapplb.reform.hmcts.net"
  ;;
  aat)
    IDAM_URI="https://idam-api.aat.platform.hmcts.net"
  ;;
  demo)
    IDAM_URI="https://idam-api.demo.platform.hmcts.net"
  ;;
  prod)
    IDAM_URI="https://idam-api.platform.hmcts.net"
  ;;
  *)
    echo ${ENV_MESSAGE}
    exit 1 ;;
esac

curl -XPOST -H 'Content-Type: application/json' ${IDAM_URI}/testing-support/accounts -d '{
    "email": "'${USER_EMAIL}'",
    "forename": "'${FORENAME}'",
    "surname": "'${SURNAME}'",
    "roles": '${USER_ROLES}',
    "password": "'${PASSWORD}'"
}'

echo -e "\nCreated user with:\nUsername: ${USER_EMAIL}\nPassword: ${PASSWORD}\nFirstname: ${FORENAME}\nSurname: ${SURNAME}\nRoles: ${USER_ROLES}"

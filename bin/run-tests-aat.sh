#!/bin/bash

ccdDefinitionRepoPath=$(dirname $(dirname $(dirname $(realpath $0))))/civil-ccd-definition

s2sSecret=${1}
testType=${2}
showBrowserWindow=${3:-false}

if [ -z "$s2sSecret" ]; then
  echo "You need to provide microservicekey-civil-service secret from civil-aat vault"
  exit 1
fi

if [ -z "$testType" ]; then
  echo "You need to provide test type: smoke, api, e2e, functional, rpa"
  exit 1
fi

cd $ccdDefinitionRepoPath

URL=https://manage-case.aat.platform.hmcts.net \
SERVICE_AUTH_PROVIDER_API_BASE_URL=http://rpe-service-auth-provider-aat.service.core-compute-aat.internal \
CCD_DATA_STORE_URL=http://ccd-data-store-api-aat.service.core-compute-aat.internal \
DM_STORE_URL=http://dm-store-aat.service.core-compute-aat.internal \
CIVIL_SERVICE_URL=http://civil-service-aat.service.core-compute-aat.internal \
IDAM_API_URL=https://idam-api.aat.platform.hmcts.net \
S2S_SECRET=$s2sSecret SHOW_BROWSER_WINDOW=$showBrowserWindow yarn test:$testType
#!/usr/bin/env bash

set -eu

dir=$(dirname ${0})

export IDAM_ADMIN_USER=idamOwner@hmcts.net
export IDAM_ADMIN_PASSWORD=Ref0rmIsFun

${dir}/add-services.sh

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi


${dir}/add-roles.sh

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

${dir}/add-users.sh

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

${dir}/add-role-assignments.sh

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

echo "Prod aat config. Please change exclusions for non prod"
${dir}/process-and-import-ccd-definition.sh "-e *-nonprod.json,AuthorisationCaseType-shuttered.json"

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

cd ..
cd civil-sdk

${dir}/process-and-import-general-apps-ccd-definition.sh "-e *-prod.json"

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

cd ..
cd civil-sdk

${dir}/import-bpmn-diagram.sh

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
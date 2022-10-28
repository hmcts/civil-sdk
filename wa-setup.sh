#!/usr/bin/env bash

export ROLE_ASSIGNMENT_URL=http://localhost:4096
export CCD_URL=http://ccd-data-store-api:4452
# Setup Users
./bin/utils/wa-create-users.sh

# Register roles
./bin/utils/wa-register-roles.sh

echo ""
echo "Setup Wiremock responses for Professional Reference Data based on existing Idam users..."
./bin/utils/wiremock.sh

echo "Deploying camunda bpmn and dmn"
./bin/utils/camunda-deployment.sh
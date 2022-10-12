#!/usr/bin/env bash

export ROLE_ASSIGNMENT_URL=http://localhost:4096
export CCD_URL=http://ccd-data-store-api:4452
# Setup Users
./wa-create-users.sh

# Register roles
./wa-register-roles.sh

echo ""
echo "Setup Wiremock responses for Professional Reference Data based on existing Idam users..."
./wiremock.sh

echo "Deploying camunda bpmn and dmn"
./camunda-deployment.sh
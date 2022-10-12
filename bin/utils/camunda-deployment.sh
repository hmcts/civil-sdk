#!/bin/bash
## Usage: ./camunda-deployment
##
## Options:
##    - SERVICE_TOKEN: which is generated with the idam-service-token.
##
## deploys bpmn/dmn to camunda.

SERVICE_TOKEN="$(sh ./idam-service-token.sh "wa_camunda_pipeline_upload")"

echo "Uploading Camunda BPMs and DMNs..."
if [[ -z "${WA_BPMNS_DMNS_PATH}" ]]; then
  echo "Environment variable WA_BPMNS_DMNS_PATH was not set skipping deployment."
else
  echo "Deploying WA Standalone Task BPMN and DMNs"
  $WA_BPMNS_DMNS_PATH/camunda-deployment.sh $SERVICE_TOKEN

fi

if [[ -z "${WA_TASK_DMNS_BPMNS_PATH}" ]]; then
  echo ""
  echo "Environment variable WA_TASK_DMNS_BPMNS_PATH was not set skipping deployment."
else
  echo ""
  echo ""
  echo "Deploying WA Task Configuration BPMN and DMNs..."
  $WA_TASK_DMNS_BPMNS_PATH/camunda-deployment.sh $SERVICE_TOKEN
fi
#!/usr/bin/env bash

set -eu

scriptPath=$(dirname $(realpath $0))
basePath=$(dirname $(dirname $scriptPath))
ccdDefinitionRepoPath=$basePath/civil-service

ccdDefinitionPath=$ccdDefinitionRepoPath/build/ccd-definition/CIVIL
definitionOutputFile="${ccdDefinitionRepoPath}/build/ccd-development-config/ccd-civil-dev.xlsx"
params="$@"

echo "ccdDefinitionPath $ccdDefinitionPath"
echo "definitionOutputFile $definitionOutputFile"
cd $basePath
if [[ ! -d civil-service || ! -d civil-ccd-definition || ! -d civil-camunda-bpmn-definition ]]; then
  echo "Error: make sure all civil repos are in the same directory"
  exit 1
fi

echo "Definition directory: ${ccdDefinitionPath}"
echo "Definition spreadsheet ${definitionOutputFile}"
echo "Additional parameters: ${params}"

mkdir -p $(dirname ${definitionOutputFile})

${scriptPath}/utils/process-definition.sh $ccdDefinitionPath $definitionOutputFile "${params}"
${scriptPath}/utils/ccd-import-definition.sh $definitionOutputFile
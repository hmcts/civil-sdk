#!/usr/bin/env bash



set -eu



scriptPath=$(dirname $(realpath $0))

basePath=$(dirname $(dirname $scriptPath))

ccdDefinitionRepoPath=$basePath/civil-general-apps-ccd-definition



ccdDefinitionPath=$ccdDefinitionRepoPath/ga-ccd-definition

definitionOutputFile="${ccdDefinitionRepoPath}/build/ccd-development-config/ccd-civil-apps-dev.xlsx"

params="$@"



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
#!/usr/bin/env bash

function getResponseFileLocation() {
  case $organisation in
    "org1")
      echo -n "prd/organisation1UsersWithoutRoles.json"
      ;;
    "org2")
      echo -n "prd/organisation2UsersWithoutRoles.json"
      ;;
    "org3")
      echo -n "prd/organisation3UsersWithoutRoles.json"
      ;;
     "org4")
      echo -n "prd/civilDamagesClaimsOrganisation1UsersWithoutRoles.json"
      ;;
    "org5")
      echo -n "prd/civilDamagesClaimsOrganisation2UsersWithoutRoles.json"
      ;;
    *)
      echo -n "${organisation}"
      ;;
  esac
}

function activeOrganisationUsersMapping() {
  sh ./api/get_mappings.sh | jq '.mappings[] | select(.request.urlPath=="/refdata/external/v1/organisations/users")'
}

organisation=${1}

if [ -z "${organisation}" ]
then
  echo "
  Error - No parameter provided.
  Valid examples:
  ./set-active-organisation-users.sh org1
  ./set-active-organisation-users.sh org2
  ./set-active-organisation-users.sh org3
  ./set-active-organisation-users.sh org4
  ./set-active-organisation-users.sh org5
  ./set-active-organisation-users.sh prd/other-mock-response-file.json"
  exit
fi

updatedMapping=$(activeOrganisationUsersMapping | jq ".response.bodyFileName=\"$(getResponseFileLocation)\"")
mappingId=$(echo "${updatedMapping}" | jq -r '.id')

sh ./api/set_mapping.sh "${mappingId}" "${updatedMapping}"

exit 0

#!/usr/bin/env bash

host="http://localhost:8765"
getMappingsUrl="${host}/__admin/mappings"

curl --insecure --fail --show-error --silent -X GET \
  "${getMappingsUrl}" \
  -H "Accept: application/json"

exit 0

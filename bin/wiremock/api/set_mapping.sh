#!/usr/bin/env bash

host="http://localhost:8765"
setMappingUrl="${host}/__admin/mappings/${1}"
mapping=${2}

curl --insecure --fail --show-error --silent -X PUT \
  "${setMappingUrl}" \
  -H "Content-Type: application/json" \
  -d "${mapping}"

exit 0

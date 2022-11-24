# Register role in CCD

ROLE=$1
USER_TOKEN=$2
SERVICE_TOKEN=$3

curl --silent --show-error -XPUT \
  http://localhost:4451/api/user-role \
  -H "Authorization: Bearer ${USER_TOKEN}" \
  -H "ServiceAuthorization: Bearer ${SERVICE_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"role":"'"${ROLE}"'","security_classification":"PUBLIC"}'
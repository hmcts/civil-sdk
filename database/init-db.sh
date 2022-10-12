#!/usr/bin/env bash

set -e

if [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ]; then
  echo "ERROR: Missing environment variable. Set value for both 'DB_USERNAME' and 'DB_PASSWORD'."
  exit 1
fi

# Create roles and databases
psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=$DB_USERNAME --set PASSWORD=$DB_PASSWORD <<-EOSQL
  CREATE USER :USERNAME WITH PASSWORD ':PASSWORD';
EOSQL

# databases
for service in idam ccd_user_profile ccd_definition ccd_data evidence ccd_definition_designer cmc dbrefdata dbuserprofile role_assignment camunda role_assignment openidm wa_workflow_api cft_task_db wa_case_event_messages_db; do
  echo "Database $service: Creating..."
psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=$DB_USERNAME --set PASSWORD=$DB_PASSWORD --set DATABASE=$service <<-EOSQL
  CREATE DATABASE :DATABASE
    WITH OWNER = :USERNAME
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
EOSQL
  echo "Database $service: Created"
done

echo "Database/User draftstore: Creating..."
psql -v ON_ERROR_STOP=1 --username postgres --set USERNAME=draftstore --set PASSWORD=draftstore --set DATABASE=draftstore <<-EOSQL
  CREATE USER :USERNAME WITH PASSWORD ':PASSWORD';
  CREATE DATABASE :DATABASE
    WITH OWNER = :USERNAME
    ENCODING = 'UTF-8'
    CONNECTION LIMIT = -1;
EOSQL
echo "Database/User draftstore Created"

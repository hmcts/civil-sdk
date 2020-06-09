#!/usr/bin/env bash

docker exec -it compose_ccd-shared-database_1 psql -U postgres -c "CREATE USER ucmc_scheduler WITH PASSWORD 'ucmc_scheduler'"
docker exec -it compose_ccd-shared-database_1 psql -U postgres -c "CREATE DATABASE ucmc_scheduler WITH OWNER ucmc_scheduler"

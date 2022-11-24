FROM postgres:11.14

COPY init-db.sh /docker-entrypoint-initdb.d

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d ccd_data -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d camunda -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d role_assignment  -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d openidm  -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d wa_workflow_api  -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d cft_task_db  -U ${DB_USERNAME}
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d wa_case_event_messages_db -U ${DB_USERNAME}

EXPOSE 5432

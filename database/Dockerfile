FROM postgres:14.3

COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD psql -c 'select 1' -d ccd_data -U ${DB_USERNAME}

EXPOSE 5432

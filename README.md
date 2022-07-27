# Civil customised version of CCD Docker :whale:

- [Prerequisites](#prerequisites)
- [Local environment setup](#local-environment-setup)
- [Elastic search](#elastic-search)
- [Camunda](#camunda)
- [Useful scripts](#useful-scripts)
- [License](#license)

## Prerequisites

- [Docker](https://www.docker.com)
    - Memory and CPU allocations may need to be increased for successful execution of ccd applications altogether. We
      recommend using the following settings for Docker:
        - CPUs: `4`
        - Memory: `11.25GB`
        - Swap: `2.5GB`
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version
  2.0.57
- [jq Json Processor](https://stedolan.github.io/jq)

## Local environment setup

1. Login to the Azure Container registry:

```shell
./ccd login
```

**Note:** If you experience any error with the above command, try `az login` first

2. Pulling latest Docker images:

```shell
./ccd compose pull
```

If you're seeing errors when pulling images, run the following command:

```shell
az acr login --name hmctspublic --subscription 8999dec3-0104-4a27-94ee-6588559729d1
```

and try pulling images again.

3. Add the docmosis API key to `compose/docmosis.yml`, or export the `DOCMOSIS_KEY` variable in your `~/.zshrc` file.

To generate a new API key [click here](https://www.docmosis.com/products/tornado/try.html).

4. Enable docker compose defaults

**Note:** If you'd like to run OCMC services as well, append `ocmc` line in `defaults.conf`.
**DO NOT COMMIT THIS CHANGE!**

```shell
./ccd enable defaults
```

5. Create docker network

```shell
docker network create ccd-network
```

6. Creating and starting the containers:

```shell
./ccd compose up -d
```

**Note:** Not all the containers may come up on first try. Run the command again a couple minutes later to bring up the
remaining.

7. Scripts to create test users and import CCD definitions are located in bin directory.

To add services:

```shell
IDAM_ADMIN_USER=<enter email> IDAM_ADMIN_PASSWORD=<enter password> ./bin/add-services.sh
```

To add roles required to import ccd definition:

```shell
IDAM_ADMIN_USER=<enter email> IDAM_ADMIN_PASSWORD=<enter password> ./bin/add-roles.sh
```

To add users:

```shell
./bin/add-users.sh
```

`IDAM_ADMIN_USER` and `IDAM_ADMIN_PASSWORD` details can be found on Confluence.

To add role assignments:

```shell
./bin/add-role-assignments.sh
```

8. Process and import ccd definition from `civil-ccd-definition` repo

**Note:** These next scripts requires you to have the other civil repositories cloned to the same directory so if you
don't have those, go get them.

```shell
./bin/process-and-import-ccd-definition.sh
```
**Note:** If you have chosen to run OCMC services as well in step 4, you need to import CMC CCD definition. You can do so by running:

```shell
docker-compose -f compose/cmc-ccd-definition-importer.yml up cmc-ccd-definition-importer
```

9. Upload Camunda diagrams from `civil-camunda-bpmn-definition` repo

```shell
./bin/import-bpmn-diagram.sh
```

### Stopping

To stop the containers and preserve the data run:

```shell
/ccd compose down -t 1
```

### Notes

To enable stubbing of the `PROXY_PAYMENTS` set the `PROXY_PAYMENTS_STUB` environment variable to the desired url.

## Elastic search

### Information

`compose/elasticsearch.yml` has been updated with latest image. For this to work the jursdiction will need to be added
to the logstash repo: [ccd-logastash](https://github.com/hmcts/ccd-logstash).

To enable ElasticSearch compose run following:

```shell
./ccd backend dm-store sidam sidam-local sidam-local-ccd xui elasticsearch
```

Please see `packer_images` directory in the logstash repo and specific adoption files for further info.

When adding a CCD definition file elastic search indexes will be created. To verify, you can hit the elastic search api
directly on `localhost:9200` with the following command. It will return all stored indexes.

```shell
curl -X GET http://localhost:9200/jurisdiction_cases
```

The following command will return all cases currently indexed.

```shell
curl -X GET http://localhost:9200/jurisdiction_cases/_search
```

**Note:** If you start elastic search after having existing cases, these cases will not be searchable using ES.

---

### CoreCaseDataApi Elastic Search Endpoint

You can search on local envs using this endpoint: `localhost:4452/searchCases?ctid=case_type`

An example of a JSON search query which would return any cases where the reference is 1234:

```json
{
  "query": {
    "match": {
      "reference": "1234"
    }
  }
}
```

Please see
[ES docs - start searching](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-search.html)
for more examples of search queries.

Example curl:

```shell
curl --location --request POST 'localhost:4452/searchCases?ctid=case_type' \
--header 'Content-Type: application/json' \
--header 'Authorization: <auth-token> \
--header 'ServiceAuthorization: <service-auth-token> \
--data-raw '{
  "query": {
    "match" : {
      "reference" : "1234"
    }
  }
}'
```

Example response:

```json
{
  "total": 1,
  "cases": [
    {
      "id": 1234,
      "jurisdiction": "jurisdiction",
      "state": "Open",
      "version": null,
      "case_type_id": "case_type",
      "created_date": "2020-03-09T16:05:01.742",
      "last_modified": "2020-03-09T16:05:01.745",
      "security_classification": "PUBLIC",
      "case_data": {},
      "data_classification": {
        "creatorId": "PUBLIC"
      },
      "after_submit_callback_response": null,
      "callback_response_status_code": null,
      "callback_response_status": null,
      "delete_draft_response_status_code": null,
      "delete_draft_response_status": null,
      "security_classifications": {
        "creatorId": "PUBLIC"
      }
    }
  ]
}

```

----

## Camunda

Camunda is part of `defaults.conf` file, so it is enabled by default.

To enable the compose file manually run the following:

```shell
./ccd enable backend dm-store sidam sidam-local sidam-local-ccd xui camunda elasticsearch
```

Camunda is available at `http://localhost:9404/`. To login into the cockpit application use:

`username: demo`

`password: demo`

Within Cockpit, you can find information around deployed processes.

The easiest way to deploy a process is via the Camunda Modeler and setting the REST endpoint value to
`http://localhost:9404/engine-rest`. However, this can also be done via the REST API. You can find full documentation of
the REST API [here.](https://docs.camunda.org/manual/latest/reference/rest/)

### Deployments

To delete all deployments and process instances from your local env run the script:

```shell
./bin/reset-camunda.sh
```

To deploy new bpmn diagrams stored in `civil-camunda-bpmn-definition` repo run the script:

```shell
./bin/import-bpmn-diagram.sh .
```

----

## Idam Stub

### Prerequisites:

Add following line to your `/etc/hosts`:

```text
127.0.0.1	ccd-test-stubs-service
```

### Enable stub

To use the Idam stub instead of real service follow the steps:

- Make sure you are in root directory (`civil-sdk`)
- Run the command to enable the stub and rebuild local environment:

```shell
export IDAM_STUB_ENABLED=true && ./bin/toggle-idam-stub.sh
```

- Run civil-service with profiles:

```text
spring.profiles.active=local,idam-stub
```

If you want to run functional tests in new terminal tab, the env variable needs to be re-exported or added to `~/.zshrc`
file:

```shell
export IDAM_STUB_ENABLED=true
```

### Switching back to real Idam

- Run the command to disable stub and rebuild local environment:

```shell
unset IDAM_STUB_ENABLED && ./bin/toggle-idam-stub.sh
```

- Run civil-service with the following profiles:

```text
spring.profiles.active=local
```

----

## Useful scripts

### Reset local wiremock mappings

```shell
curl -X DELETE http://localhost:8765/__admin/mappings && curl -X POST http://localhost:8765/__admin/mappings/reset
```

### Connect to preview database

```shell
kubectl port-forward {YOUR_PR_POSTGRES_POD} -n civil 9999:5432
```

Example:

```shell
kubectl port-forward civil-service-pr-168-postgresql-0 -n civil 9999:5432
```

After running the command you can connect to `postgres` database on `localhost:9999` with `hmcts` user and password.

### Remove stuck PR

```shell
./bin/remove-stuck-pr {REPOSITORY} {PR_NUMBER}
```

This script supports either `ccd`, `service`, or `camunda` for `REPOSITORY`.

Example:

```shell
./bin/remove-stuck-pr service 165
./bin/remove-stuck-pr.sh general-applications 306
./bin/remove-stuck-pr.sh general-apps-ccd-definition 306
```

### Run tests against AAT

```shell
./run-tests-aat.sh {S2S_SECRET} {TEST_TYPE} {SHOW_BROWSER_WINDOW}
```

S2S secret needs to be provided, it's microservicekey-civil-service from civil-aat vault. Example:

```shell
./run-tests-aat.sh SECRET_FROM_AAT_VAULT e2e true
```

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

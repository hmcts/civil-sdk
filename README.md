# Civil claims customised version of CCD Docker :whale:

- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
- [Elastic search](#elastic-search)
- [Camunda](#camunda)
- [License](#license)

## Prerequisites

- [Docker](https://www.docker.com)

*Memory and CPU allocations may need to be increased for successful execution of ccd applications altogether*

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) - minimum version 2.0.57
- [jq Json Processor](https://stedolan.github.io/jq)

## Sync with ccd-docker
```bash
git pull git@github.com:hmcts/ccd-docker.git master
```

## Quick start
Login to the Azure Container registry:

```bash
./ccd login
```
Note:
if you experience any error with the above command, try `az login` first

Pulling latest Docker images:

```bash
./ccd compose pull
```
You will need to add the docmosis API key to the `docmosis.yml` file found in `compose/docmosis.yml`, or export the `DOCMOSIS_KEY` variable in your `~/.zshrc` file.

To generate a new API key [click here](https://www.docmosis.com/products/tornado/try.html).

Creating and starting the containers:

```bash
./ccd compose up -d
```

Scripts to create test users and import CCD definitions are located in bin directory.

To add services:

```
 IDAM_ADMIN_USER=<enter email> IDAM_ADMIN_PASSWORD=<enter password> ./bin/add-services.sh
```

To add roles required to import ccd definition:

```
 IDAM_ADMIN_USER=<enter email> IDAM_ADMIN_PASSWORD=<enter password> ./bin/add-roles.sh
```

To add users:

```
./bin/add-users.sh
```

`IDAM_ADMIN_USER` and `IDAM_ADMIN_PASSWORD` details can be found on confluence.

To process and import ccd definition from `civil-ccd-definition` repo:
```
./bin/process-and-import-ccd-definition.sh
```

To enable stubbing of the ```PROXY_PAYMENTS``` set the ```PROXY_PAYMENTS_STUB``` environment variable to the desired url.

## Elastic search

### Information
`compose/elasticsearch.yml` has been updated with latest image. For this to work the jursdiction will need to be added
to the logstash repo: [ccd-logastash](https://github.com/hmcts/ccd-logstash).

To enable ElasticSearch compose run following:

```
./ccd backend dm-store sidam sidam-local sidam-local-ccd xui elasticsearch
```

Please see `packer_images` directory in the logstash repo and specific adoption files for further info.

When adding a CCD definition file elastic search indexes will be created. To verify, you can hit the elastic search
api directly on `localhost:9200` with the following command. It will return all stored indexes.
```shell script
curl -X GET http://localhost:9200/jurisdiction_cases
```

The following command will return all cases currently indexed.
```shell script
 curl -X GET http://localhost:9200/jurisdiction_cases/_search
```

Note: if you start elastic search after having existing cases, these cases will not be searchable using ES.

---

### CoreCaseDataApi Elastic Search Endpoint

You can search on local envs using this endpoint: `localhost:4452/searchCases?ctid=case_type`

An example of a JSON search query which would return any cases where the reference is 1234:
```json
{
    "query": {
        "match" : {
          "reference" : "1234"
        }
    }
}
```

Please see [ES docs - start searching](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started-search.html) for more
examples of search queries.

Example curl:
```shell script
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

```
./ccd enable backend dm-store sidam sidam-local sidam-local-ccd xui camunda
```

Camunda is available at `http://localhost:9404/`. To login into the cockpit application use:

`username: demo`

`password: demo`

Within Cockpit you can find information around deployed processes.

The easiest way to deploy a process is via the Camunda Modeler and setting the REST endpoint value to
`http://localhost:9404/engine-rest`. However this can also be done via the REST API. You can find full documentation of the
REST API [here.](https://docs.camunda.org/manual/latest/reference/rest/)

### Deployments

To delete all deployments and process instances from your local env run the script:

```
./bin/reset-camunda.sh
```

To deploy new bpmn diagrams stored in `civil-camunda-bpmn-definition` repo run the script:
```
./bin/import-bpmn-diagram.sh
```

----

## Idam Stub

### Prerequisites:
Add following line to your `/etc/hosts`:
```
127.0.0.1	ccd-test-stubs-service
```

### Enable stub
To use Idam stub instead of real service follow the steps:

- Make sure you are in root directory (`civil-sdk`)
- Run the command to enable stub and rebuild local environment:
```
export IDAM_STUB_ENABLED=true && ./bin/toggle-idam-stub.sh
```
- Run civil-service with profiles:
```
spring.profiles.active=local,idam-stub
```

If you want to run functional tests in new terminal tab, the env variable needs to be re-exported or added to `~/.zshrc` file:
```
export IDAM_STUB_ENABLED=true
```

### Switching back to real Idam

- Run the command to disable stub and rebuild local environment:
```
unset IDAM_STUB_ENABLED && ./bin/toggle-idam-stub.sh
```

- Run civil-service with the following profiles:
 ```
 spring.profiles.active=local
 ```

----

This project should aim to keep upto date with the [base CCD Docker project](https://github.com/hmcts/ccd-docker)

## LICENSE

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

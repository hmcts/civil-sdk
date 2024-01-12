DROP SCHEMA IF EXISTS fridam CASCADE;
CREATE SCHEMA fridam AUTHORIZATION openidm;

-- -----------------------------------------------------
-- Table fridam.service
-- -----------------------------------------------------

CREATE TABLE fridam.service (
  label text NOT NULL,
  description text NOT NULL,
  allowedroles text[],
  onboardingroles text[],
  onboardingendpoint text,
  oauth2clientid text NOT NULL DEFAULT '',
  CONSTRAINT service_pkey PRIMARY KEY (label)
);

-- -----------------------------------------------------
-- Table fridam.clustercache
-- -----------------------------------------------------

CREATE TABLE fridam.clustercache (
    key VARCHAR(255) NOT NULL,
    assignments text[] NOT NULL,
    CONSTRAINT clustercache_pkey PRIMARY KEY (key)
);

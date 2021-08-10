-- Deploy ggircs:swrs/history/schema to pg

BEGIN;

create schema swrs_history;
comment on schema swrs is 'A schema containing all versions of the reports and attachments from SWRS. Available in Metabase';

COMMIT;

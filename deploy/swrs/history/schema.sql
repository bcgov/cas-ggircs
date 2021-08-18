-- Deploy ggircs:swrs/history/schema to pg

BEGIN;

create schema swrs_history;
comment on schema swrs_history is 'A schema containing all versions of the reports and attachments from SWRS(Single Window Reporting System). This differs from the swrs schema in that the swrs schema contains only the final version of the data. Available in Metabase';

COMMIT;

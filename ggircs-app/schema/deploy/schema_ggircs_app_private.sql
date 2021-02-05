-- Deploy ggircs-app:schema_ggircs_app_private to pg

begin;

create schema ggircs_app_private;

comment on schema ggircs_app_private is 'Contains private data for the GGIRCS web application';
commit;

-- Deploy ggircs-app:schema_ggircs_app to pg

begin;

create schema ggircs_app;

comment on schema ggircs_app is 'Contains the data specific to the GGIRCS web application';
commit;

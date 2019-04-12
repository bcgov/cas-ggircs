-- Deploy ggircs:schema_ggircs to pg

begin;

create schema ggircs;
comment on schema ggircs is 'A schema for the Greenhouse Gas Industrial Reporting and Control System (GGIRCS) powered by the Environment and Climate Change Canada (ECCC) Single Window Reporting System (SWRS)';

commit;

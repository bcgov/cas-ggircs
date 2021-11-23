-- Deploy ggircs:swrs/public/table/taxed_venting_emission_type to pg
-- requires: swrs/public/schema

begin;

create table swrs.taxed_venting_emission_type (
  id integer primary key,
  taxed_emission_type varchar(1000)
);

comment on table swrs.emission_category is 'Table of emisison types that are carbon taxed in relation to venting as per https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA';
comment on column swrs.emission_category.id is 'Unique ID for the taxed_venting_emission_type table';
comment on column swrs.emission_category.swrs_emission_category is 'The name of the carbon taxed emission type';

commit;

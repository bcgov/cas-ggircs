-- Deploy ggircs:swrs/public/table/emission_category to pg
-- requires: swrs/public/schema

begin;

create table swrs.emission_category (
  id integer primary key generated always as identity,
  swrs_emission_category varchar(1000),
  carbon_taxed boolean default true,
  category_definition varchar(100000)
);

comment on table swrs.emission_category is 'Table of emission categories used in the CIIP program as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';
comment on column swrs.emission_category.id is 'Unique ID for the emission_category';
comment on column swrs.emission_category.swrs_emission_category is 'The emission category name as displayed in the swrs xml reports';
comment on column swrs.emission_category.carbon_taxed is 'Boolean carbon_taxed column indicates whether or not a fuel reported in this category is taxed';
comment on column swrs.emission_category.category_definition is 'Definition of the emission_category as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';

commit;

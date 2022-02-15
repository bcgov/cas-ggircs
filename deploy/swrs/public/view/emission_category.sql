-- Deploy ggircs:swrs/public/view/emission_category to pg
-- requires: swrs/parameters/table/emission_category

begin;

create or replace view swrs.emission_category as (
  select * from ggircs_parameters.emission_category
);

comment on view swrs.emission_category is 'A view that retrieves the data from the ggircs_parameters.emission_category table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.emission_category.id is 'Unique ID for the emission_category';
comment on column swrs.emission_category.swrs_emission_category is 'The emission category name as displayed in the swrs xml reports';
comment on column swrs.emission_category.carbon_taxed is 'Boolean carbon_taxed column indicates whether or not a fuel reported in this category is taxed';
comment on column swrs.emission_category.category_definition is 'Definition of the emission_category as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';

commit;

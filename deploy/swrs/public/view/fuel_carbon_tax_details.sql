-- Deploy ggircs:swrs/public/view/fuel_carbon_tax_details to pg
-- requires: swrs/parameters/table/fuel_carbon_tax_detail

begin;

create or replace view swrs.fuel_carbon_tax_details as (
  select * from ggircs_parameters.fuel_carbon_tax_detail
);

comment on view swrs.fuel_carbon_tax_details is 'A view that retrieves the data from the ggircs_parameters.fuel_carbon_tax_detail table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';

commit;

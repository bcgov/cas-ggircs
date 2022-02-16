-- Deploy ggircs:swrs/public/view/fuel_mapping to pg
-- requires: swrs/parameters/table/fuel_mapping

begin;

create or replace view swrs.fuel_mapping as (
  select id, fuel_type, fuel_carbon_tax_detail_id as fuel_carbon_tax_details_id from ggircs_parameters.fuel_mapping
);

comment on view swrs.fuel_mapping is 'A view that retrieves the data from the ggircs_parameters.fuel_mapping table. This view is necessary to maintain relationships defined elsewhere like CIIP and metabase after the table was moved to the ggircs_parameters schema';
comment on column swrs.fuel_mapping.id is 'The internal primary key for the mapping';
comment on column swrs.fuel_mapping.fuel_type is 'The type of fuel (from GHGR), Foreign key to fuel';
comment on column swrs.fuel_mapping.fuel_carbon_tax_details_id is 'The foreign key to swrs.fuel_carbon_tax_details';

commit;

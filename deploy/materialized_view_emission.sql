-- Deploy ggircs:materialized_view_emission to pg
-- requires: materialized_view_fuel

begin;

-- Emissions from Fuel
create materialized view ggircs_swrs.emission as (
with x as (
  select
       ghgr_import_id,
       id  as fuel_id,
       unit_id,
       activity_id,
       fuel_type,
       xml_hunk     as fuel_xml_hunk
  from ggircs_swrs.fuel
  order by ghgr_import_id desc
)
select
      row_number() over (order by ghgr_import_id asc, x.fuel_id asc) as id,
      x.ghgr_import_id,
      x.fuel_id,
      x.unit_id,
      x.activity_id,
      x.fuel_type,
      emission_details.emission_type,
      emission_details.gas_type,
      emission_details.methodology,
      emission_details.not_applicable,
      emission_details.quantity,
      emission_details.calculated_quantity,
      CAST(emission_details.groups as varchar(1000)) as emission_category
from x,
     xmltable(
       '//Emission'
       passing fuel_xml_hunk
       columns
           gas_type varchar(1000) path 'GasType[normalize-space(.)]',
           emission_type varchar(1000) path '../@EmissionsType[normalize-space(.)]',
           methodology varchar(1000) path 'Methodology[normalize-space(.)]',
           not_applicable boolean path 'NotApplicable[normalize-space(.)]',
           quantity numeric(1000,0) path 'Quantity[normalize-space(.)]' default 0,
           calculated_quantity numeric(1000,0) path 'CalculatedQuantity[normalize-space(.)]' default 0,
           groups xml path 'Groups/EmissionGroupTypes/varchar(1000)()[contains(normalize-space(.), "BC_ScheduleB_")]',
           xml_hunk xml path '.'
    ) as emission_details
) with no data;

create unique index ggircs_emission_primary_key on ggircs_swrs.emission (id);

comment on materialized view ggircs_swrs.emission is 'The materialized view containing the information on emissions';
comment on column ggircs_swrs.emission.id is 'The primary key for the fuel';
comment on column ggircs_swrs.emission.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.emission.fuel_id is 'A foreign key reference to ggircs_swrs.fuel';
comment on column ggircs_swrs.emission.unit_id is 'A foreign key reference to ggircs_swrs.unit';
comment on column ggircs_swrs.emission.activity_id is 'A foreign key reference to ggrics_swrs.activity';
comment on column ggircs_swrs.emission.fuel_type is 'The type of the fuel';
comment on column ggircs_swrs.emission.emission_type is 'The type of the emission';
comment on column ggircs_swrs.emission.gas_type is 'The type of the gas';
comment on column ggircs_swrs.emission.methodology is 'The emission methodology';
comment on column ggircs_swrs.emission.not_applicable is 'Is the emission applicable/NA';
comment on column ggircs_swrs.emission.quantity is 'The quantity of the emission';
comment on column ggircs_swrs.emission.calculated_quantity is 'The calcualted quantity of the emission';
comment on column ggircs_swrs.emission.emission_category is 'The emission groups (categories) as xml';

commit;

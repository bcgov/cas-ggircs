-- Deploy ggircs:materialized_view_unit to pg
-- requires: table_ghgr_import

begin;

-- Units from SubActivity
-- todo: explore any other attributes for units
create materialized view ggircs_swrs.unit as (
  with x as (
    select ghgr_import.id       as ghgr_import_id,
           ghgr_import.xml_file as source_xml
    from ggircs_swrs.ghgr_import
    order by ghgr_import_id desc
  )
  select ghgr_import_id,
         unit_details.*

  from x,
       xmltable(
           '//Unit'
           passing source_xml
           columns
             activity_name varchar(1000) not null path 'name(./ancestor::Process/parent::*)',
             process_idx integer not null path 'string(count(./ancestor::Process/preceding-sibling::Process))',
             sub_process_idx integer not null path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))',
             units_idx integer not null path 'string(count(./ancestor::Units/preceding-sibling::Units))',
             unit_idx integer not null path 'string(count(./preceding-sibling::Unit))',
             unit_name varchar(1000) path './UnitName|./ancestor::Units/@UnitType',
             unit_description varchar(1000) path './UnitDesc/text()',
             -- cogen_unit xml path './COGenUnit',
             cogen_unit_name varchar(1000) path './COGenUnit/CogenUnitName',
             cogen_cycle_type varchar(1000) path './COGenUnit/CycleType',
             cogen_nameplate_capacity varchar(1000) path './COGenUnit/NameplateCapacity',
             cogen_net_power varchar(1000) path './COGenUnit/NetPower',
             cogen_steam_heat_acq_quantity varchar(1000) path './COGenUnit/SteamHeatAcquisitionAcquiredQuantity',
             cogen_steam_heat_acq_name varchar(1000) path './COGenUnit/SteamHeatAcquisitionProviderName',
             cogen_supplemental_firing_purpose varchar(1000) path './COGenUnit/SupplementalFiringPurpose',
             cogen_thermal_output_quantity varchar(1000) path './COGenUnit/ThermalOutputQuantity',
             -- non_cogen_unit xml path './NonCOGenUnit'
             non_cogen_nameplate_capacity varchar(1000) path './NonCOGenUnit/NameplateCapacity',
             non_cogen_net_power varchar(1000) path './NonCOGenUnit/NetPower',
             non_cogen_unit_name varchar(1000) path './NonCOGenUnit/NonCogenUnitName'
             -- fuels xml path './Fuels/*' -- implemented as ggircs_swrs.fuel
         ) as unit_details
) with no data;

create unique index ggircs_unit_primary_key on ggircs_swrs.unit (ghgr_import_id, activity_name, process_idx, sub_process_idx, units_idx, unit_idx);

comment on materialized view ggircs_swrs.unit is 'The materialized view containing the information on swrs machinery units';
comment on column ggircs_swrs.unit.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import.id';
comment on column ggircs_swrs.unit.activity_name is 'The name of the activity';
comment on column ggircs_swrs.unit.process_idx is 'The number of preceding Process siblings before this Process';
comment on column ggircs_swrs.unit.sub_process_idx is 'The number of preceding SubProcess siblings before this SubProcess';
comment on column ggircs_swrs.unit.units_idx is 'The number of preceding Units siblings before this Units';
comment on column ggircs_swrs.unit.unit_idx is 'The number of preceding Unit siblings before this Unit';
comment on column ggircs_swrs.unit.unit_name is 'The name of the unit of machinery emitting greenhouse gas';
comment on column ggircs_swrs.unit.unit_description is 'The description of the unit of machinery emitting greenhouse gas';
comment on column ggircs_swrs.unit.cogen_unit_name is 'The name of the cogen unit';
comment on column ggircs_swrs.unit.cogen_cycle_type is 'The cycle type of the cogen unit';
comment on column ggircs_swrs.unit.cogen_nameplate_capacity is 'The nameplate capacity] of the cogen unit';
comment on column ggircs_swrs.unit.cogen_net_power is 'The net power of the cogen unit';
comment on column ggircs_swrs.unit.cogen_steam_heat_acq_quantity is 'The steam heat quantity of the cogen unit';
comment on column ggircs_swrs.unit.cogen_steam_heat_acq_name is 'The steam heat name of the cogen unit';
comment on column ggircs_swrs.unit.cogen_supplemental_firing_purpose is 'The firing purpose of the cogen unit';
comment on column ggircs_swrs.unit.cogen_thermal_output_quantity is 'The thermal output of the cogen unit';
comment on column ggircs_swrs.unit.non_cogen_nameplate_capacity is 'The nameplate capacity of the non-cogen unit';
comment on column ggircs_swrs.unit.non_cogen_net_power is 'The net power of the non-cogen unit';
comment on column ggircs_swrs.unit.non_cogen_unit_name is 'The name of the non-cogen unit';



commit;

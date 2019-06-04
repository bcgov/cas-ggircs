-- Deploy ggircs:table_unit to pg
-- requires: schema_ggircs

begin;

create table ggircs.unit (

    id                                  integer primary key,
    ghgr_import_id                      integer,
    activity_name                       varchar(1000),
    unit_name                           varchar(1000),
    unit_description                    varchar(1000),
    cogen_unit_name                     varchar(1000),
    cogen_cycle_type                    varchar(1000),
    cogen_nameplate_capacity            numeric,
    cogen_net_power                     numeric,
    cogen_steam_heat_acq_quantity       numeric,
    cogen_steam_heat_acq_name           varchar(1000),
    cogen_supplemental_firing_purpose   varchar(1000),
    cogen_thermal_output_quantity       numeric,
    non_cogen_nameplate_capacity        numeric,
    non_cogen_net_power                 numeric,
    non_cogen_unit_name                 varchar(1000)

);

comment on table ggircs.unit is 'The table containing the information on swrs machinery units';
comment on column ggircs.unit.id is 'The primary key';
comment on column ggircs.unit.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import.id';
comment on column ggircs.unit.activity_name is 'The name of the activity';
comment on column ggircs.unit.unit_name is 'The name of the unit of machinery emitting greenhouse gas';
comment on column ggircs.unit.unit_description is 'The description of the unit of machinery emitting greenhouse gas';
comment on column ggircs.unit.cogen_unit_name is 'The name of the cogen unit';
comment on column ggircs.unit.cogen_cycle_type is 'The cycle type of the cogen unit';
comment on column ggircs.unit.cogen_nameplate_capacity is 'The nameplate capacity] of the cogen unit';
comment on column ggircs.unit.cogen_net_power is 'The net power of the cogen unit';
comment on column ggircs.unit.cogen_steam_heat_acq_quantity is 'The steam heat quantity of the cogen unit';
comment on column ggircs.unit.cogen_steam_heat_acq_name is 'The steam heat name of the cogen unit';
comment on column ggircs.unit.cogen_supplemental_firing_purpose is 'The firing purpose of the cogen unit';
comment on column ggircs.unit.cogen_thermal_output_quantity is 'The thermal output of the cogen unit';
comment on column ggircs.unit.non_cogen_nameplate_capacity is 'The nameplate capacity of the non-cogen unit';
comment on column ggircs.unit.non_cogen_net_power is 'The net power of the non-cogen unit';
comment on column ggircs.unit.non_cogen_unit_name is 'The name of the non-cogen unit';

commit;

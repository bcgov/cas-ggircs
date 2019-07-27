-- Deploy ggircs:ciip_table_equipment to pg
-- requires: ciip_table_application

begin;

create table ciip_2018.equipment (
    id                                  serial primary key,
    application_id                      integer references ciip_2018.application(id),
    facility_id                         integer references ciip_2018.facility(id),
    operator_id                         integer references ciip_2018.operator(id),
    equipment_category                  varchar(1000),
    equipment_identifier                varchar(1000),
    equipment_type                      varchar(1000),
    power_rating                        numeric,
    load_factor                         numeric,
    utilization                         numeric,
    runtime_hours                       numeric,
    design_efficiency                   numeric,
    electrical_source                   varchar(1000),
    consumption_allocation_method       varchar(1000),
    comments                            varchar(10000),
    inlet_sales_compression_same_engine boolean,
    inlet_suction_pressure              numeric,
    inlet_discharge_pressure            numeric,
    sales_suction_pressure              numeric,
    sales_discharge_pressure            numeric,
    volume_throughput                   numeric,
    volume_units                        varchar(1000),
    volume_estimation_method            varchar(1000)
);

create index ciip_equipment_application_foreign_key on ciip_2018.equipment(application_id);
create index ciip_equipment_facility_foreign_key on ciip_2018.equipment(facility_id);
create index ciip_equipment_operator_foreign_key on ciip_2018.equipment(operator_id);

comment on table ciip_2018.equipment is 'The table containing equipment information';
comment on column ciip_2018.equipment.id                                  is 'The primary key';
comment on column ciip_2018.equipment.application_id                      is 'The application id';
comment on column ciip_2018.equipment.facility_id                         is 'The facility id';
comment on column ciip_2018.equipment.operator_id                         is 'The operator id';
comment on column ciip_2018.equipment.equipment_category                  is 'The category of equipment (Gas Fired or Electrical)';
comment on column ciip_2018.equipment.equipment_identifier                is 'The identifier of the equipment';
comment on column ciip_2018.equipment.equipment_type                      is 'The type of equiment';
comment on column ciip_2018.equipment.power_rating                        is 'The power rating in kW';
comment on column ciip_2018.equipment.load_factor                         is 'The % load factor';
comment on column ciip_2018.equipment.utilization                         is 'The % utilization';
comment on column ciip_2018.equipment.runtime_hours                       is 'The runtime hours';
comment on column ciip_2018.equipment.design_efficiency                   is 'The design efficiency';
comment on column ciip_2018.equipment.electrical_source                   is 'The electrical source (Grid or Self-generated)';
comment on column ciip_2018.equipment.consumption_allocation_method       is 'The allocation method description';
comment on column ciip_2018.equipment.comments                            is 'The comments regarding entered information';
comment on column ciip_2018.equipment.inlet_sales_compression_same_engine is 'Whether the same engine is used for inlet/sales compression';
comment on column ciip_2018.equipment.inlet_suction_pressure              is 'The inlet compression suction pressure';
comment on column ciip_2018.equipment.inlet_discharge_pressure            is 'The inlet compression discharge pressure';
comment on column ciip_2018.equipment.sales_suction_pressure              is 'The sales compression suction pressure';
comment on column ciip_2018.equipment.sales_discharge_pressure            is 'The sales compression discharge pressure';
comment on column ciip_2018.equipment.volume_throughput                   is 'The volume throughput';
comment on column ciip_2018.equipment.volume_units                        is 'The output/throughput volume units';
comment on column ciip_2018.equipment.volume_estimation_method            is 'The estimation method or meter identifiers';

commit;

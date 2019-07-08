-- Deploy ggircs:ciip_table_equipment to pg
-- requires: ciip_table_application

begin;

create table ciip.equipment (
    id                             serial primary key,
    application_id                 integer references ciip.application(id),
    equipment_category             varchar(1000),
    equipment_identifier           varchar(1000),
    equipment_type                 varchar(1000),
    power_rating                   numeric,
    load_factor                    numeric,
    utilization                    numeric,
    runtime_hours                  numeric,
    design_efficiency              numeric,
    electrical_source              varchar(1000),
    consumption_allocation_method  varchar(1000),
    comments                       varchar(10000),
    inlet_sales_compression_same_engine boolean,
    inlet_suction_pressure         numeric,
    inlet_discharge_pressure       numeric,
    sales_suction_pressure         numeric,
    sales_compression_pressure     numeric,
    volume_throughput              numeric,
    volume_units                   varchar(1000),
    volume_estimation_method       varchar(1000)
);

create index ciip_equipment_application_foreign_key on ciip.equipment(application_id);

commit;
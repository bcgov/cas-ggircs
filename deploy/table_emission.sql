-- Deploy ggircs:table_emission to pg
-- requires: schema_ggircs

begin;

create table ggircs.emission (

    id                        int generated always as identity primary key,
    ghgr_import_id            integer,
    activity_name             varchar(1000),
    sub_activity_name         varchar(1000),
    unit_name                 varchar(1000),
    sub_unit_name             varchar(1000),
    fuel_name                 varchar(1000),
    emission_type             varchar(1000),
    gas_type                  varchar(1000),
    methodology               varchar(1000),
    not_applicable            boolean,
    quantity                  numeric,
    calculated_quantity       numeric,
    emission_category         varchar(1000)

);

comment on table ggircs.emission is 'The table containing the information on emissions';
comment on column ggircs.emission.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import';
comment on column ggircs.emission.activity_name is 'The name of the activity (partial fk reference)';
comment on column ggircs.emission.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column ggircs.emission.unit_name is 'The name of the unit (partial fk reference)';
comment on column ggircs.emission.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column ggircs.emission.fuel_name is 'The disambiguation string for Fuel (only on old reports)';
comment on column ggircs.emission.emission_type is 'The type of the emission';
comment on column ggircs.emission.gas_type is 'The type of the gas';
comment on column ggircs.emission.methodology is 'The emission methodology';
comment on column ggircs.emission.not_applicable is 'Is the emission applicable/NA';
comment on column ggircs.emission.quantity is 'The quantity of the emission';
comment on column ggircs.emission.calculated_quantity is 'The CO2 Equivalent quantity of the emission';
comment on column ggircs.emission.emission_category is 'The emissions category';

commit;

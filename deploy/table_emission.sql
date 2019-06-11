-- Deploy ggircs:table_emission to pg
-- requires: schema_ggircs

begin;

create table ggircs.emission (

    id                        integer primary key,
    ghgr_import_id            integer,
    activity_id               integer,
    single_facility_id        integer,
    lfo_facility_id           integer,
    fuel_id                   integer,
    naics_id                  integer,
    organisation_id           integer,
    report_id                 integer,
    unit_id                   integer,
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
comment on column ggircs.emission.id is 'The primary key';
comment on column ggircs.emission.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import';
comment on column ggircs.emission.activity_id is 'A foreign key reference to ggircs.activity';
comment on column ggircs.emission.single_facility_id is 'A foreign key reference to ggircs.single_facility';
comment on column ggircs.emission.lfo_facility_id is 'A foreign key reference to ggircs.lfo_facility';
comment on column ggircs.emission.fuel_id is 'A foreign key reference to ggircs.fuel';
comment on column ggircs.emission.naics_id is 'A foreign key reference to ggircs.naics';
comment on column ggircs.emission.organisation_id is 'A foreign key reference to ggircs.organisation';
comment on column ggircs.emission.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.emission.unit_id is 'A foreign key reference to ggircs.unit';
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

-- add the foreign key constraint on emission.activity_id = activity.activity_id

commit;

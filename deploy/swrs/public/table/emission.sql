-- Deploy ggircs:table_emission to pg
-- requires: schema_ggircs

begin;

create table swrs.emission (

    id                        integer primary key,
    ghgr_import_id            integer,
    activity_id               integer references swrs.activity(id),
    facility_id               integer references swrs.facility(id),
    fuel_id                   integer references swrs.fuel(id),
    naics_id                  integer references swrs.naics(id),
    organisation_id           integer references swrs.organisation(id),
    report_id                 integer references swrs.report(id),
    unit_id                   integer references swrs.unit(id),
    fuel_mapping_id           integer references swrs.fuel_mapping(id),
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

create index ggircs_emission_activity_foreign_key on swrs.emission(activity_id);
create index ggircs_emission_facility_foreign_key on swrs.emission(facility_id);
create index ggircs_emission_fuel_foreign_key on swrs.emission(fuel_id);
create index ggircs_emission_naics_foreign_key on swrs.emission(naics_id);
create index ggircs_emission_organisation_foreign_key on swrs.emission(organisation_id);
create index ggircs_emission_report_foreign_key on swrs.emission(report_id);
create index ggircs_emission_unit_foreign_key on swrs.emission(unit_id);

comment on table swrs.emission is 'The table containing the information on emissions';
comment on column swrs.emission.id is 'The primary key';
comment on column swrs.emission.ghgr_import_id is 'A foreign key reference to swrs.ghgr_import';
comment on column swrs.emission.activity_id is 'A foreign key reference to swrs.activity';
comment on column swrs.emission.facility_id is 'A foreign key reference to swrs.facility';
comment on column swrs.emission.fuel_id is 'A foreign key reference to swrs.fuel';
comment on column swrs.emission.naics_id is 'A foreign key reference to swrs.naics';
comment on column swrs.emission.organisation_id is 'A foreign key reference to swrs.organisation';
comment on column swrs.emission.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.emission.unit_id is 'A foreign key reference to swrs.unit';
comment on column swrs.emission.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs.emission.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column swrs.emission.unit_name is 'The name of the unit (partial fk reference)';
comment on column swrs.emission.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column swrs.emission.fuel_name is 'The disambiguation string for Fuel (only on old reports)';
comment on column swrs.emission.emission_type is 'The type of the emission';
comment on column swrs.emission.gas_type is 'The type of the gas';
comment on column swrs.emission.methodology is 'The emission methodology';
comment on column swrs.emission.not_applicable is 'Is the emission applicable/NA';
comment on column swrs.emission.quantity is 'The quantity of the emission';
comment on column swrs.emission.calculated_quantity is 'The CO2 Equivalent quantity of the emission';
comment on column swrs.emission.emission_category is 'The emissions category';

commit;

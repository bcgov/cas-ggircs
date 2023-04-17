-- Revert ggircs:swrs/public/table/measured_emission_factor_001 from pg

begin;

begin;

create table swrs.measured_emission_factor (

    id                                  integer primary key,
    fuel_id                             integer references swrs.fuel(id),
    eccc_xml_file_id                      integer,
    activity_name                       varchar(1000),
    sub_activity_name                   varchar(1000),
    unit_name                           varchar(1000),
    sub_unit_name                       varchar(1000),
    measured_emission_factor_amount     numeric,
    measured_emission_factor_gas        varchar(1000),
    measured_emission_factor_unit_type  varchar(1000)
);

create index ggircs_measured_emission_factor_fuel_foreign_key on swrs.measured_emission_factor(fuel_id);

comment on table swrs.measured_emission_factor is 'The table containing the information on fuels';
comment on column swrs.measured_emission_factor.id is 'The primary key';
comment on column swrs.measured_emission_factor.fuel_id is 'A foreign key reference to swrs.fuel';
comment on column swrs.measured_emission_factor.eccc_xml_file_id is 'A foreign key reference to swrs.eccc_xml_file';
comment on column swrs.measured_emission_factor.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs.measured_emission_factor.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column swrs.measured_emission_factor.unit_name is 'The name of the unit (partial fk reference)';
comment on column swrs.measured_emission_factor.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column swrs.measured_emission_factor.measured_emission_factor_amount is 'The amount of the measured_emission';
comment on column swrs.measured_emission_factor.measured_emission_factor_gas is 'The gas type of the measured_emission';
comment on column swrs.measured_emission_factor.measured_emission_factor_unit_type is 'The unit type of the measured_emission';
comment on column swrs.measured_emission_factor.measured_emission_factor_unit_type is 'The measured emission factor unit type of the fuel';

commit;

-- Deploy ggircs:materialized_view_measured_emission_factor to pg
-- requires: table_eccc_xml_file

begin;

drop materialized view swrs_transform.measured_emission_factor;
create materialized view swrs_transform.measured_emission_factor as (
  select row_number() over () as id, id as eccc_xml_file_id, factor_details.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//MeasuredEmissionFactor'
           passing xml_file
           columns
             activity_name varchar(1000) path 'name(./ancestor::ActivityData/*)' not null,
             sub_activity_name varchar(1000) path 'name(./ancestor::ActivityData/*/*)' not null,
             unit_name varchar(1000) path 'name(./ancestor::Substance/parent::*/parent::*/parent::*)' not null,
             sub_unit_name varchar(1000) path 'name(./ancestor::Substance/parent::*/parent::*)' not null,
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null,
             sub_process_idx integer path 'string(count(./ancestor::SubProcess/preceding-sibling::SubProcess))' not null,
             units_idx integer path 'string(count(./ancestor::Units/preceding-sibling::Units))' not null,
             unit_idx integer path 'string(count(./ancestor::Unit/preceding-sibling::Unit))' not null,
             substances_idx integer path 'string(count(./ancestor::Substance/parent::*/preceding-sibling::*))' not null,
             substance_idx integer path 'string(count(./ancestor::Substance/preceding-sibling::Substance))' not null,
             fuel_idx integer path 'string(count(./ancestor::Fuel/preceding-sibling::Fuel))' not null,
             measured_emission_factor_idx integer path 'string(count(./preceding-sibling::MeasuredEmissionFactor))' not null,
             measured_emission_factor_amount numeric(1000,3) path './MeasuredEmissionFactorAmount|./ancestor::Fuel/MeasuredEmissionFactor',
             measured_emission_factor_gas varchar(1000) path './MeasuredEmissionFactorGas',
             measured_emission_factor_unit_type varchar(1000) path './MeasuredEmissionFactorUnitType|./ancestor::Fuel/MeasuredEmissionFactorUnitType'
         ) as factor_details
) with no data;

create unique index ggircs_measured_emission_factor_primary_key on swrs_transform.measured_emission_factor (eccc_xml_file_id, activity_name, sub_activity_name, unit_name, sub_unit_name, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx, fuel_idx, measured_emission_factor_idx);

comment on materialized view swrs_transform.measured_emission_factor is 'The materialized view containing the information on fuels';
comment on column swrs_transform.measured_emission_factor.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.measured_emission_factor.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file';
comment on column swrs_transform.measured_emission_factor.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.unit_name is 'The name of the unit (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.process_idx is 'The number of preceding Process siblings before this Process (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.sub_process_idx is 'The number of preceding SubProcess siblings before this SubProcess (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.units_idx is 'The number of preceding Units siblings before this Units (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.unit_idx is 'A foreign key reference to swrs_transform.unit (partial fk reference)';
comment on column swrs_transform.measured_emission_factor.substances_idx is 'The number of preceding siblings before the Substances';
comment on column swrs_transform.measured_emission_factor.substance_idx is 'The number of preceding siblings before the Substance';
comment on column swrs_transform.measured_emission_factor.fuel_idx is 'The number of preceding siblings before the fuel';
comment on column swrs_transform.measured_emission_factor.measured_emission_factor_idx is 'The number of preceding siblings before the measured emission factor';
comment on column swrs_transform.measured_emission_factor.measured_emission_factor_amount is 'The amount of the measured_emission';
comment on column swrs_transform.measured_emission_factor.measured_emission_factor_gas is 'The gas type of the measured_emission';
comment on column swrs_transform.measured_emission_factor.measured_emission_factor_unit_type is 'The unit type of the measured_emission';
comment on column swrs_transform.measured_emission_factor.measured_emission_factor_unit_type is 'The measured emission factor unit type of the fuel';

commit;

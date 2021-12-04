-- Deploy ggircs:materialized_view_fuel to pg
-- requires: table_eccc_xml_file

begin;

-- Fuels from Units
drop materialized view if exists swrs_transform.fuel;
create materialized view swrs_transform.fuel as (
  select row_number() over () as id, id as eccc_xml_file_id, fuel_details.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//Fuel'
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
             fuel_idx integer path 'string(count(./preceding-sibling::Fuel))' not null,
             fuel_type varchar(1000) path './FuelType',
             fuel_classification varchar(1000) path './FuelClassification',
             fuel_description varchar(1000) path './FuelDescription',
             fuel_units varchar(1000) path './FuelUnits|./Units',
             annual_fuel_amount numeric path './AnnualFuelAmount[normalize-space(.)]',
             annual_weighted_avg_carbon_content numeric path './AnnualWeightedAverageCarbonContent[normalize-space(.)]',
             annual_weighted_avg_hhv numeric path './AnnualWeightedAverageHighHeatingValue[normalize-space(.)]',
             annual_steam_generation numeric path './AnnualSteamGeneration[normalize-space(.)]',
             alternative_methodology_description varchar(10000) path './AlternativeMethodologyDescription',
             other_flare_details varchar(1000) path './OtherFlareDetails',
             q1 numeric path './Q1[normalize-space(.)]',
             q2 numeric path './Q2[normalize-space(.)]',
             q3 numeric path './Q3[normalize-space(.)]',
             q4 numeric path './Q4[normalize-space(.)]',
             wastewater_processing_factors xml path './WastewaterProcessingFactors',
             measured_conversion_factors xml path './MeasuredConversionFactors',
             emission_category varchar(1000) path '(./descendant::Groups/EmissionGroupTypes/text()[contains(normalize-space(.), "BC_ScheduleB_")])[1]'
         ) as fuel_details
) with no data;

create unique index ggircs_fuel_primary_key on swrs_transform.fuel (eccc_xml_file_id, activity_name, sub_activity_name, unit_name, sub_unit_name, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx, fuel_idx);

comment on materialized view swrs_transform.fuel is 'The materialized view containing the information on fuels';
comment on column swrs_transform.fuel.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.fuel.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file';
comment on column swrs_transform.fuel.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs_transform.fuel.sub_activity_name is 'The name of the sub_activity (partial fk reference)';
comment on column swrs_transform.fuel.unit_name is 'The name of the unit (partial fk reference)';
comment on column swrs_transform.fuel.sub_unit_name is 'The name of the sub_unit (partial fk reference)';
comment on column swrs_transform.fuel.process_idx is 'The number of preceding Process siblings before this Process (partial fk reference)';
comment on column swrs_transform.fuel.sub_process_idx is 'The number of preceding SubProcess siblings before this SubProcess (partial fk reference)';
comment on column swrs_transform.fuel.units_idx is 'The number of preceding Units siblings before this Units (partial fk reference)';
comment on column swrs_transform.fuel.unit_idx is 'A foreign key reference to swrs_transform.unit (partial fk reference)';
comment on column swrs_transform.fuel.substances_idx is 'The number of preceding siblings before the Substances';
comment on column swrs_transform.fuel.substance_idx is 'The number of preceding siblings before the Substance';
comment on column swrs_transform.fuel.fuel_idx is 'The primary key for the fuel';
comment on column swrs_transform.fuel.fuel_type is 'The type of the fuel';
comment on column swrs_transform.fuel.fuel_classification is 'The classification of the fuel';
comment on column swrs_transform.fuel.fuel_description is 'The description of the fuel';
comment on column swrs_transform.fuel.fuel_units is 'The units of the fuel';
comment on column swrs_transform.fuel.annual_fuel_amount is 'The annual amount of the fuel';
comment on column swrs_transform.fuel.annual_weighted_avg_carbon_content is 'The annual weight avg of the fuel carbon content';
comment on column swrs_transform.fuel.annual_weighted_avg_hhv is 'The annual weight avg of the high heating value of the fuel';
comment on column swrs_transform.fuel.annual_steam_generation is 'The annual steam generation of the fuel';
comment on column swrs_transform.fuel.alternative_methodology_description is 'The description of the fuels alternative methodology';
comment on column swrs_transform.fuel.other_flare_details is 'The other flare details concerning the fuel';
comment on column swrs_transform.fuel.q1 is 'The fuel used in the first quarter';
comment on column swrs_transform.fuel.q2 is 'The fuel used in the second quarter';
comment on column swrs_transform.fuel.q3 is 'The fuel used in the third quarter';
comment on column swrs_transform.fuel.q4 is 'The fuel used in the fourth quarter';

comment on column swrs_transform.fuel.wastewater_processing_factors is 'Details on the wastewater processing factors for this fuel';
comment on column swrs_transform.fuel.measured_conversion_factors is 'Details on the measured_conversion_factors for this fuel';

commit;

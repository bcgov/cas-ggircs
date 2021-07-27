-- Deploy ggircs:swrs/transform/materialized_view/r3_emission to pg
-- requires: swrs/transform/schema
-- requires: swrs/extract/table/eccc_xml_file

begin;

-- Emissions from Fuel
create materialized view swrs_transform.r3_emission as (
  select row_number() over () as id, id as eccc_xml_file_id,
         emission_details.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//TotalRow[ancestor::TotalAttributableEmissions and ancestor::ReportData/ReportDetails/ReportType[text()="R3"]]'
           passing xml_file
           columns
             activity_name varchar(1000) path 'name(./ancestor::ActivityData/*)' not null,
             emissions_idx integer path 'string(count(./ancestor::Emissions/preceding-sibling::Emissions))' not null,
             emission_idx integer path 'string(count(./preceding-sibling::TotalRow))' not null,
             gas_type varchar(1000) path 'translate(normalize-space(GasName), " ", "")',
             quantity numeric path 'normalize-space(Quantity)' default 0,
             calculated_quantity numeric path 'normalize-space(CalculatedQuantity)' default 0,
             cas_number varchar(1000) path 'normalize-space(CasNumber)'
         ) as emission_details
  order by eccc_xml_file_id
) with no data;

create unique index ggircs_r3_emission_primary_key on swrs_transform.r3_emission (eccc_xml_file_id, activity_name, emissions_idx, emission_idx);

comment on materialized view swrs_transform.r3_emission is 'The materialized view containing the information on emissions for R3 Reports (R3 reports are for facilities that emit < 10000 tCo2e';
comment on column swrs_transform.r3_emission.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.r3_emission.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file';
comment on column swrs_transform.r3_emission.activity_name is 'The name of the activity (partial fk reference)';
comment on column swrs_transform.r3_emission.emissions_idx is 'The number of preceding Emissions siblings before this emission. This index signifies where in the report this block of emissions was reported';
comment on column swrs_transform.r3_emission.emission_idx is 'The number of preceding Emission siblings before this emission. This index signifies where this emission was reported within an emissions_idx';
comment on column swrs_transform.r3_emission.gas_type is 'The type of the gas';
comment on column swrs_transform.r3_emission.quantity is 'The quantity of the emission';
comment on column swrs_transform.r3_emission.calculated_quantity is 'The CO2 Equivalent quantity of the emission';
comment on column swrs_transform.r3_emission.cas_number is 'The materialized view containing the information on emissions for R3 Reports (R3 reports are for facilities that emit < 10000 tCO2e, but are still required to submit an emission report under the Greenhouse Gas Emission Reporting Regulation, section 14, paragraph 6)';

commit;

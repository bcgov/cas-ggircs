-- Deploy ggircs:swrs/transform/materialized_view/historical_report_emission_data to pg
-- requires: swrs/extract/table/eccc_xml_file

begin;

create materialized view swrs_transform.historical_report_emission_data as (
  select
    row_number() over () as id,
    id as eccc_xml_file_id,
    emission_data.*
  from swrs_extract.eccc_xml_file,
      xmltable(
        '/TotalEmissions'
        passing xml_file
        columns
          grand_total_emission path 'normalize-space(/TotalGroups[@TotalGroupType="TotalGHGEmissionGas"]/Totals/Emissions[@EmissionsGasType="GHGEmissionGas"]/GrandTotal/Total)',
          reporting_only_grand_total path 'normalize-space(/TotalGroups[@TotalGroupType="ReportingOnlyEmissions"]/Totals/Emissions[@EmissionsGasType="ReportingOnlyByGas"]/GrandTotal/Total)',
          co2bioc path 'normalize-space(/TotalGroups[@TotalGroupType="ReportingOnlyEmissions"]/Totals/Emissions[@EmissionsGasType="ReportingOnlyByGas"]/TotalRow/GasType[text()="CO2bioC"]/preceding-sibling::Quantity)',
      ) as emission_data
) with no data;


create unique index ggircs_report_primary_key on swrs_transform.report (eccc_xml_file_id);

comment on materialized view swrs_transform.historical_report_emission_data is 'The materialized view housing additional report emission data required for compliance and enforcement, derived from eccc_xml_file table';
comment on column swrs_transform.historical_report_emission_data.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.historical_report_emission_data.eccc_xml_file_id is 'The internal primary key for the file';
comment on column swrs_transform.historical_report_emission_data.grand_total_emission is 'The total GHGR emissions reported in this report. Used by compliance and enforcement.';
comment on column swrs_transform.historical_report_emission_data.reporting_only_grand_total is 'The total emissions under the ReportingOnly tag. Used by compliance and enforcement';
comment on column swrs_transform.historical_report_emission_data.co2bioc is 'The total quantity of CO2bioC reported in this report. Used by compliance and enforcement';

commit;

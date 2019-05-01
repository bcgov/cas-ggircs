-- Deploy ggircs:materialized_view_naics to pg
-- requires: materialized_view_facility

begin;

create materialized view ggircs_swrs.naics as (
  with x as (
    select _report.source_xml as source_xml,
           _report.id         as report_id,
           _report.swrs_report_id,
           _report.imported_at,
           _report.swrs_facility_id,
           _facility.id       as facility_id
    from ggircs_swrs.report as _report
           inner join ggircs_swrs.facility as _facility on _report.id = _facility.report_id
    order by _report.id asc
  )
  select row_number() over (order by report_id asc) as id,
         facility_id,
         swrs_facility_id,
         naics.*,
         row_number() over (
           partition by swrs_facility_id
           order by
             report_id desc,
             naics_priority desc,
             naics_code desc
           ) as swrs_naics_history_id
  from x,
       xmltable(
           '/ReportData/RegistrationData/Facility/Identifiers/NAICSCodeList/NAICSCode/NaicsPriority[normalize-space(.)][contains(., "Primary")]|/ReportData/RegistrationData/Facility/Identifiers/NAICSCodeList/NAICSCode/ActivityPercentage[normalize-space(.)][contains(., "100")]'
           passing x.source_xml
           columns
             naics_classification text path './../NAICSClassification[normalize-space(.)]',
             naics_code text path './../Code[normalize-space(.)]',
             naics_priority text path 'normalize-space(.)'
         ) as naics
) with no data;
create unique index ggircs_naics_primary_key on ggircs_swrs.naics (id);
create index ggircs_swrs_naics_history on ggircs_swrs.naics (swrs_naics_history_id);

commit;

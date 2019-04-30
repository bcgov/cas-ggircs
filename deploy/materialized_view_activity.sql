-- Deploy ggircs:materialized_view_activity to pg
-- requires: materialized_view_report

BEGIN;

create materialized view ggircs_swrs.activity as (
  with x as (
    select
           report.source_xml,
           report.id as report_id,
           report.swrs_report_id as swrs_report_id,
           report.imported_at,
           report.swrs_report_history_id
    from ggircs_swrs.report
  )
  select row_number() over (order by x.report_id asc) as id,
         x.report_id,
         x.swrs_report_id,
         activity_details.*,
         x.swrs_report_history_id
  from x,
       xmltable(
           '/ReportData/ActivityData/ActivityPages/Process/SubProcess'
           passing x.source_xml
           columns
             process_name varchar(1000) path '../@ProcessName[normalize-space(.)]', -- Todo: Redundant. Remove in cleanup phase
             subprocess_name varchar(1000) path './@SubprocessName[normalize-space(.)]',
             --unit_type text path './Units/@UnitType[normalize-space(.)]', -- Todo: Extract as concatenated result
             information_requirement varchar(1000) path './@InformationRequirement[normalize-space(.)]',
             sub_activity_xml xml path '.'
         ) as activity_details
);

create unique index ggircs_activity_primary_key on ggircs_swrs.activity (id);

COMMIT;


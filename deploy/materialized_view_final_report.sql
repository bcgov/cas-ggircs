-- Deploy ggircs:materialized_view_final_report to pg
-- requires: materialized_view_facility

begin;

create materialized view ggircs_swrs.final_report as (
  with final_report as (
    with x as (
      select report.swrs_report_id,
         min(swrs_report_history_id) as swrs_auth_history_id
      from ggircs_swrs.report
      where status = 'Submitted'
      group by swrs_report_id
    )
    select report.*
    from ggircs_swrs.report
        inner join x
            on report.swrs_report_id = x.swrs_report_id
            and report.swrs_report_history_id = x.swrs_auth_history_id
  ),
  report_facility as (
    select
        report.id as report_id,
        facility.id as facility_id
    from final_report as report
    left outer join ggircs_swrs.facility on report.id = ggircs_swrs.facility.ghgr_import_id
    where report.status = 'Submitted'
    order by report.swrs_report_id desc, report.swrs_report_history_id asc
  )
  select * from report_facility
 -- select count(report_id), count(distinct report_id) from report_facility
) with no data;

create unique index ggircs_final_report_primary_key on ggircs_swrs.final_report (report_id);

commit;

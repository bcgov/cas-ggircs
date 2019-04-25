-- Deploy ggircs:materialized_view_report to pg
-- requires: schema_ggircs_private
-- requires: table_raw_report

begin;

create materialized view ggircs_private.report as (
  with x as (
    select id          as ghgr_id,
           xml_file    as source_xml,
           imported_at as imported_at
    from ggircs_private.raw_report
    order by ghgr_id desc
  )
  select
    --Todo: use sequence for id
    row_number() over (order by ghgr_id asc) as id,
    ghgr_id,
    x.source_xml,
    x.imported_at,
    report_details.*,
    report_status.*,
    row_number() over (
      partition by report_details.swim_report_id
      order by
        imported_at desc,
        ghgr_id desc
      )                                      as swim_report_history_id
  from x,
       xmltable(
           '/ReportData/ReportDetails'
           passing source_xml
           columns
             swim_report_id numeric path 'ReportID',
             prepop_report_id numeric path 'PrepopReportID', -- null
             report_type text path 'ReportType',
             swim_facility_id numeric path 'FacilityId',
             swim_organisation_id numeric path 'OrganisationId',
             reporting_period_duration numeric path 'ReportingPeriodDuration'
         ) as report_details,

       xmltable(
           '/ReportData/ReportDetails/ReportStatus'
           passing source_xml
           columns
             status text path 'Status|ReportStatus', -- Unknown, In Progress, Submitted, Archived, Completed
             version text path 'Version',
             submission_date text path 'SubmissionDate', -- null
             last_modified_by text path 'LastModifiedBy',
             update_comment text path 'UpdateComment' -- null
         ) as report_status
);


create unique index ggircs_private_report_primary_key on ggircs_private.report (id);
create index ggircs_private_report_history on ggircs_private.report (swim_report_history_id);

commit;
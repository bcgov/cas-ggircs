-- Deploy ggircs:function_export_report_to_ggircs to pg
-- requires: materialized_view_report
-- requires: materialized_view_final_report

begin;

create or replace function ggircs_swrs.export_report_to_ggircs()
  returns void as
$function$
    begin
        delete from ggircs.report;
        insert into ggircs.report (id, ghgr_import_id, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                                       reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

        select _report.id, _report.ghgr_import_id, imported_at, _report.swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

        from ggircs_swrs.report as _report
        inner join ggircs_swrs.final_report as _final_report on _report.ghgr_import_id = _final_report.ghgr_import_id;

    end
$function$ language plpgsql volatile;
commit;

-- Deploy ggircs:function_export_activity_to_ggircs to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: materialized_view_activity

begin;

create or replace function ggircs_swrs.export_activity_to_ggircs()
  returns void as
$function$
    begin
        delete from ggircs.activity;
        insert into ggircs.activity (id, ghgr_import_id, facility_id,  report_id, activity_name, process_name, sub_process_name, information_requirement)

        select _activity.id, _activity.ghgr_import_id, _facility.id, _report.id, _activity.activity_name, _activity.process_name, _activity.sub_process_name, _activity.information_requirement

        from ggircs_swrs.activity as _activity

        inner join ggircs_swrs.final_report as _final_report on _activity.ghgr_import_id = _final_report.ghgr_import_id

        -- FK Activity ->  Facility
        left join ggircs_swrs.facility as _facility
          on _activity.ghgr_import_id = _facility.ghgr_import_id

        -- FK Activity -> Report
        left join ggircs_swrs.report as _report
          on _activity.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;

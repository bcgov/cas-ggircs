-- Deploy ggircs:function_load_activity to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: materialized_view_activity

begin;

create or replace function ggircs_swrs_transform.load_activity()
  returns void as
$function$
    begin
        delete from ggircs_swrs_load.activity;
        insert into ggircs_swrs_load.activity (id, ghgr_import_id, facility_id,  report_id, activity_name, process_name, sub_process_name, information_requirement)

        select _activity.id, _activity.ghgr_import_id, _facility.id, _report.id, _activity.activity_name, _activity.process_name, _activity.sub_process_name, _activity.information_requirement

        from ggircs_swrs_transform.activity as _activity

        inner join ggircs_swrs_transform.final_report as _final_report on _activity.ghgr_import_id = _final_report.ghgr_import_id

        -- FK Activity ->  Facility
        left join ggircs_swrs_transform.facility as _facility
          on _activity.ghgr_import_id = _facility.ghgr_import_id

        -- FK Activity -> Report
        left join ggircs_swrs_transform.report as _report
          on _activity.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;

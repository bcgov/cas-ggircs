-- Deploy ggircs:function_load_additional_data to pg
-- requires: materialized_view_report
-- requires: materialized_view_activity
-- requires: materialized_view_final_report
-- requires: materialized_view_additional_data

begin;

create or replace function ggircs_swrs_transform.load_additional_data()
  returns void as
$function$
    begin
        delete from ggircs_swrs_load.additional_data;
        insert into ggircs_swrs_load.additional_data (id, ghgr_import_id, activity_id, report_id,
                                       activity_name, grandparent, parent, class, attribute, attr_value, node_value)

        select _additional_data.id, _additional_data.ghgr_import_id, _activity.id, _report.id, _additional_data.activity_name, _additional_data.grandparent, _additional_data.parent,
               _additional_data.class, _additional_data.attribute, _additional_data.attr_value, _additional_data.node_value

        from ggircs_swrs_transform.additional_data as _additional_data

        inner join ggircs_swrs_transform.final_report as _final_report on _additional_data.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Additional Data -> Activity
        left join ggircs_swrs_transform.activity as _activity
          on _additional_data.ghgr_import_id = _activity.ghgr_import_id
          and _additional_data.process_idx = _activity.process_idx
          and _additional_data.sub_process_idx = _activity.sub_process_idx
          and _additional_data.activity_name = _activity.activity_name
        -- FK Additional Data -> Report
        left join ggircs_swrs_transform.report as _report
          on _additional_data.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;

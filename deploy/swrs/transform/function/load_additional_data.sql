-- Deploy ggircs:function_load_additional_data to pg
-- requires: materialized_view_report
-- requires: materialized_view_activity
-- requires: materialized_view_final_report
-- requires: materialized_view_additional_data

begin;

create or replace function swrs_transform.load_additional_data()
  returns void as
$function$
    begin
        delete from swrs_load.additional_data;
        insert into swrs_load.additional_data (id, eccc_xml_file_id, activity_id, report_id,
                                       activity_name, grandparent, parent, class, attribute, attr_value, node_value)

        select _additional_data.id, _additional_data.eccc_xml_file_id, _activity.id, _report.id, _additional_data.activity_name, _additional_data.grandparent, _additional_data.parent,
               _additional_data.class, _additional_data.attribute, _additional_data.attr_value, _additional_data.node_value

        from swrs_transform.additional_data as _additional_data

        inner join swrs_transform.final_report as _final_report on _additional_data.eccc_xml_file_id = _final_report.eccc_xml_file_id
        -- FK Additional Data -> Activity
        left join swrs_transform.activity as _activity
          on _additional_data.eccc_xml_file_id = _activity.eccc_xml_file_id
          and _additional_data.process_idx = _activity.process_idx
          and _additional_data.sub_process_idx = _activity.sub_process_idx
          and _additional_data.activity_name = _activity.activity_name
        -- FK Additional Data -> Report
        left join swrs_transform.report as _report
          on _additional_data.eccc_xml_file_id = _report.eccc_xml_file_id;

    end
$function$ language plpgsql volatile;

commit;

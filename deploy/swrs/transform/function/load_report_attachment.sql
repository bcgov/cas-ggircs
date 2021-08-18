-- Deploy ggircs:swrs/transform/function/load_report_attachment to pg
-- requires: swrs/transform/materialized_view/historical_report_attachment_data
-- requires: swrs/history/table/attachments

create or replace function swrs_transform.load_report_attachment()
  returns void as
$function$
    begin
        delete from swrs_history_load.report_attachment;
        insert into swrs_history_load.report_attachment(
          id,
          eccc_xml_file_id,
          process_name,
          sub_process_name,
          information_requirement,
          file_number,
          uploaded_file_name,
          uploaded_by,
          uploaded_at
        )

        select * from swrs_transform.historical_report_attachment_data;
    end
$function$ language plpgsql volatile;
commit;

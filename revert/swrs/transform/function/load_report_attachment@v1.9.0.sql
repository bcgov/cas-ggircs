-- Deploy ggircs:swrs/transform/function/load_report_attachment to pg
-- requires: swrs/transform/materialized_view/historical_report_attachment_data
-- requires: swrs/history/table/attachments

begin;

create or replace function swrs_transform.load_report_attachment()
  returns void as
$function$
    begin
        delete from swrs_history_load.report_attachment;

        insert into swrs_history_load.report_attachment(
          id,
          report_id,
          process_name,
          sub_process_name,
          information_requirement,
          file_number,
          uploaded_file_name,
          uploaded_by,
          uploaded_at
        )

        select
          _hrad.id,
          _report.id,
          _hrad.process_name,
          _hrad.sub_process_name,
          _hrad.information_requirement,
          _hrad.file_number,
          _hrad.uploaded_file_name,
          _hrad.uploaded_by,
          _hrad.uploaded_at
        from swrs_transform.historical_report_attachment_data _hrad
        left join swrs_transform.report as _report
          on _hrad.eccc_xml_file_id = _report.eccc_xml_file_id;
    end
$function$ language plpgsql volatile;
commit;

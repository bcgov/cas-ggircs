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
          uploaded_at,
          file_path,
          md5_hash,
          zip_file_name
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
          _hrad.uploaded_at,
          _attachment.attachment_file_path,
          _attachment.attachment_file_md5_hash,
          _zipfile.zip_file_name
        from swrs_transform.historical_report_attachment_data _hrad
          left join swrs_transform.report as _report
            on _hrad.eccc_xml_file_id = _report.eccc_xml_file_id
          left join swrs_extract.eccc_zip_file _zipfile
            on _hrad.zip_file_id = _zipfile.id
          left join swrs_extract.eccc_attachment _attachment
            on _hrad.swrs_report_id = _attachment.swrs_report_id
        where _hrad.file_number = _attachment.source_type_id
          and _hrad.uploaded_file_name = _attachment.attachment_uploaded_file_name
          and _hrad.zip_file_id = _attachment.zip_file_id;
    end
$function$ language plpgsql volatile;
commit;

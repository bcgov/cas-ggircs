-- Deploy ggircs:swrs/transform/function/load_other_venting to pg

begin;

create or replace function swrs_transform.load_other_venting()
  returns void as
$function$
  begin

    delete from swrs_load.other_venting;
    insert into swrs_load.other_venting(id, eccc_xml_file_id, report_id, detail_tag, detail_value)
    select _other_venting.id, _other_venting.eccc_xml_file_id, _report.id, _other_venting.detail_tag, _other_venting.detail_value
    from swrs_transform.other_venting as _other_venting
    inner join swrs_transform.final_report as _final_report on _other_venting.eccc_xml_file_id = _final_report.eccc_xml_file_id
    left join swrs_transform.report as _report
    on _other_venting.eccc_xml_file_id = _report.eccc_xml_file_id;
  end
$function$ language plpgsql volatile;

commit;

-- Deploy ggircs:function_load_identifier to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: materialized_view_identifier

begin;

create or replace function swrs_transform.load_identifier()
  returns void as
$function$
    begin

        delete from swrs_load.identifier;
        insert into swrs_load.identifier(id, eccc_xml_file_id, facility_bcghgid_id, facility_id,  report_id, swrs_facility_id, path_context, identifier_type, identifier_value)

        select _identifier.id, _identifier.eccc_xml_file_id, _facility_bcghgid.id, _facility.id,  _report.id, _identifier.swrs_facility_id, _identifier.path_context, _identifier.identifier_type, _identifier.identifier_value

        from swrs_transform.identifier as _identifier

        inner join swrs_transform.final_report as _final_report on _identifier.eccc_xml_file_id = _final_report.eccc_xml_file_id
        -- FK Identifier -> Facility
        left join swrs_transform.facility as _facility
          on _identifier.eccc_xml_file_id = _facility.eccc_xml_file_id
        -- FK Identifier -> Report
        left join swrs_transform.report as _report
          on _identifier.eccc_xml_file_id = _report.eccc_xml_file_id
        left join swrs_load.facility as _facility_bcghgid
          on _identifier.eccc_xml_file_id = _facility_bcghgid.eccc_xml_file_id
          and (((_identifier.path_context = 'RegistrationData'
                 and _identifier.identifier_type = 'BCGHGID'
                 and _identifier.identifier_value is not null
                 and _identifier.identifier_value != '' )

                   and (select id from swrs_transform.identifier as __identifier
                      where __identifier.eccc_xml_file_id = _facility_bcghgid.eccc_xml_file_id
                      and __identifier.path_context = 'VerifyTombstone'
                      and __identifier.identifier_type = 'BCGHGID'
                      and __identifier.identifier_value is not null
                      and __identifier.identifier_value != '') is null)
              or (_identifier.path_context = 'VerifyTombstone'
                 and _identifier.identifier_type = 'BCGHGID'
                 and _identifier.identifier_value is not null
                 and _identifier.identifier_value != '' ));

    end
$function$ language plpgsql volatile;

commit;

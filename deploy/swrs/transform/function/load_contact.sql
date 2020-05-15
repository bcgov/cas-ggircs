-- Deploy ggircs:function_load_contact to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_facility
-- requires: materialized_view_address
-- requires: materialized_view_final_report
-- requires: materialized_view_contact

begin;

create or replace function swrs_transform.load_contact()
  returns void as
$function$
    begin

        delete from swrs_load.contact;
        insert into swrs_load.contact (id, eccc_xml_file_id, address_id, facility_id,  report_id, organisation_id, path_context, contact_type, given_name, family_name, initials, telephone_number, extension_number,
                                    fax_number, email_address, position, language_correspondence)

        select _contact.id, _contact.eccc_xml_file_id, _address.id, _facility.id,  _report.id, _organisation.id, _contact.path_context, _contact.contact_type, _contact.given_name, _contact.family_name,
               _contact.initials, _contact.telephone_number, _contact.extension_number, _contact.fax_number, _contact.email_address, _contact.position, _contact.language_correspondence

        from swrs_transform.contact as _contact

        inner join swrs_transform.final_report as _final_report on _contact.eccc_xml_file_id = _final_report.eccc_xml_file_id
        -- todo: this could be re-worked when we get a better idea how to handle path_context
        --FK Contact -> Address
        left join swrs_transform.address as _address
          on _contact.eccc_xml_file_id = _address.eccc_xml_file_id
          and _address.type = 'Contact'
          and _contact.contact_idx = _address.contact_idx
          and(
                (_contact.path_context = 'RegistrationData'
                and _address.path_context = 'RegistrationData')
             or
                (_contact.path_context = 'VerifyTombstone'
                and _address.path_context = 'VerifyTombstone')
              )
        -- FK Contact ->  Facility
        left join swrs_transform.facility as _facility
            on _contact.eccc_xml_file_id = _facility.eccc_xml_file_id

        --FK Contact -> Report
        left join swrs_transform.report as _report
          on _contact.eccc_xml_file_id = _report.eccc_xml_file_id
        --FK Contact -> Organisation
        left join swrs_transform.organisation as _organisation
            on _contact.eccc_xml_file_id = _organisation.eccc_xml_file_id;

    end
$function$ language plpgsql volatile;

commit;

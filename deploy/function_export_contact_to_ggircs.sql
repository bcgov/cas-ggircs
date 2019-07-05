-- Deploy ggircs:function_export_contact_to_ggircs to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_facility
-- requires: materialized_view_address
-- requires: materialized_view_final_report
-- requires: materialized_view_contact

begin;

create or replace function ggircs_swrs.export_contact_to_ggircs()
  returns void as
$function$
    begin

        insert into ggircs.contact (id, ghgr_import_id, address_id, facility_id,  report_id, organisation_id, path_context, contact_type, given_name, family_name, initials, telephone_number, extension_number,
                                    fax_number, email_address, position, language_correspondence)

        select _contact.id, _contact.ghgr_import_id, _address.id, _facility.id,  _report.id, _organisation.id, _contact.path_context, _contact.contact_type, _contact.given_name, _contact.family_name,
               _contact.initials, _contact.telephone_number, _contact.extension_number, _contact.fax_number, _contact.email_address, _contact.position, _contact.language_correspondence

        from ggircs_swrs.contact as _contact

        inner join ggircs_swrs.final_report as _final_report on _contact.ghgr_import_id = _final_report.ghgr_import_id
        -- todo: this could be re-worked when we get a better idea how to handle path_context
        --FK Contact -> Address
        left join ggircs_swrs.address as _address
          on _contact.ghgr_import_id = _address.ghgr_import_id
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
        left join ggircs_swrs.facility as _facility
            on _contact.ghgr_import_id = _facility.ghgr_import_id

        --FK Contact -> Report
        left join ggircs_swrs.report as _report
          on _contact.ghgr_import_id = _report.ghgr_import_id
        --FK Contact -> Organisation
        left join ggircs_swrs.organisation as _organisation
            on _contact.ghgr_import_id = _organisation.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;

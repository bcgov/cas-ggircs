-- Deploy ggircs:function_load_address to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_facility
-- requires: materialized_view_parent_organisation
-- requires: materialized_view_final_report
-- requires: materialized_view_address

begin;

create or replace function swrs_transform.load_address()
  returns void as
$function$
    begin

        delete from swrs_load.address;
        insert into swrs_load.address (id, ghgr_import_id, facility_id,  organisation_id, parent_organisation_id, report_id, swrs_facility_id, swrs_organisation_id, path_context, type, physical_address_municipality, physical_address_unit_number,
                                    physical_address_street_number, physical_address_street_number_suffix, physical_address_street_name, physical_address_street_type,
                                    physical_address_street_direction, physical_address_prov_terr_state, physical_address_postal_code_zip_code, physical_address_country,
                                    physical_address_national_topographical_description, physical_address_additional_information, physical_address_land_survey_description,
                                    mailing_address_delivery_mode, mailing_address_po_box_number, mailing_address_unit_number, mailing_address_rural_route_number,
                                    mailing_address_street_number, mailing_address_street_number_suffix, mailing_address_street_name, mailing_address_street_type,
                                    mailing_address_street_direction, mailing_address_municipality, mailing_address_prov_terr_state, mailing_address_postal_code_zip_code,
                                    mailing_address_country, mailing_address_additional_information, geographic_address_latitude, geographic_address_longitude)

        select _address.id, _address.ghgr_import_id, _facility.id,  _organisation.id, _parent_organisation.id, _report.id, _address.swrs_facility_id, _address.swrs_organisation_id,
               _address.path_context,_address.type, _address.physical_address_municipality, _address.physical_address_unit_number,
               _address.physical_address_street_number, _address.physical_address_street_number_suffix, _address.physical_address_street_name, _address.physical_address_street_type,
               _address.physical_address_street_direction, _address.physical_address_prov_terr_state, _address.physical_address_postal_code_zip_code, _address.physical_address_country,
               _address.physical_address_national_topographical_description, _address.physical_address_additional_information, _address.physical_address_land_survey_description,
               _address.mailing_address_delivery_mode, _address.mailing_address_po_box_number, _address.mailing_address_unit_number, _address.mailing_address_rural_route_number,
               _address.mailing_address_street_number, _address.mailing_address_street_number_suffix, _address.mailing_address_street_name, _address.mailing_address_street_type,
               _address.mailing_address_street_direction, _address.mailing_address_municipality, _address.mailing_address_prov_terr_state, _address.mailing_address_postal_code_zip_code,
               _address.mailing_address_country, _address.mailing_address_additional_information, _address.geographic_address_latitude, _address.geographic_address_longitude

        from swrs_transform.address as _address

        inner join swrs_transform.final_report as _final_report on _address.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Address -> Facility
        left join swrs_transform.facility as _facility
            on _address.ghgr_import_id = _facility.ghgr_import_id
        --FK Address -> Organisation
        left join swrs_transform.organisation as _organisation
          on _address.ghgr_import_id = _organisation.ghgr_import_id
          and _address.type = 'Organisation'
        -- FK Address -> Parent Organisation
        left join swrs_transform.parent_organisation as _parent_organisation
          on _address.ghgr_import_id = _parent_organisation.ghgr_import_id
          and _address.type = 'ParentOrganisation'
          and _address.parent_organisation_idx = _parent_organisation.parent_organisation_idx
          and(
                (_parent_organisation.path_context = 'RegistrationData'
                and _address.path_context = 'RegistrationData')
             or
                (_parent_organisation.path_context = 'VerifyTombstone'
                and _address.path_context = 'VerifyTombstone')
              )
        -- FK Address -> Report
        left join swrs_transform.report as _report
          on _address.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;

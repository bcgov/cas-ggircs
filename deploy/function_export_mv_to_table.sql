-- Deploy ggircs:function_export_mv_to_table to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_additional_data

begin;

create or replace function ggircs_swrs.export_mv_to_table()
  returns void as
$function$
  begin

    -- Refresh materialized views
    perform ggircs_swrs.refresh_materialized_views('with data');

    -- Populate tables
    -- REPORT
    perform ggircs_swrs.export_report_to_ggircs();

    -- ORGANISATION
    perform ggircs_swrs.export_organisation_to_ggircs();

    -- FACILITY
    perform ggircs_swrs.export_facility_to_ggircs();

    -- ACTIVITY
    perform ggircs_swrs.export_activity_to_ggircs();

    -- UNIT
    perform ggircs_swrs.export_unit_to_ggircs();

    -- IDENTIFIER
    perform ggircs_swrs.export_identifier_to_ggircs();

    -- NAICS
    perform ggircs_swrs.export_naics_to_ggircs();

    -- FUEL
    perform ggircs_swrs.export_fuel_to_ggircs();

    -- EMISSION
    perform ggircs_swrs.export_emission_to_ggircs();

    -- PERMIT
    perform ggircs_swrs.export_permit_to_ggircs();

    -- PARENT ORGANISATION
    perform ggircs_swrs.export_parent_organisation_to_ggircs();

    -- ADDRESS
    perform ggircs_swrs.export_address_to_ggircs();

    -- CONTACT
    delete from ggircs.contact;
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
    left join ggircs_swrs.organisation as _organisation
        on _contact.ghgr_import_id = _organisation.ghgr_import_id
      ;

    -- ADDITIONAL DATA
    delete from ggircs.additional_data;
    insert into ggircs.additional_data (id, ghgr_import_id, activity_id, report_id,
                                   activity_name, grandparent, parent, class, attribute, attr_value, node_value)

    select _additional_data.id, _additional_data.ghgr_import_id, _activity.id, _report.id, _additional_data.activity_name, _additional_data.grandparent, _additional_data.parent,
           _additional_data.class, _additional_data.attribute, _additional_data.attr_value, _additional_data.node_value

    from ggircs_swrs.additional_data as _additional_data

    inner join ggircs_swrs.final_report as _final_report on _additional_data.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Additional Data -> Activity
    left join ggircs_swrs.activity as _activity
      on _additional_data.ghgr_import_id = _activity.ghgr_import_id
      and _additional_data.process_idx = _activity.process_idx
      and _additional_data.sub_process_idx = _activity.sub_process_idx
      and _additional_data.activity_name = _activity.activity_name
    -- FK Additional Data -> Report
    left join ggircs_swrs.report as _report
      on _additional_data.ghgr_import_id = _report.ghgr_import_id
      ;

    -- MEASURED EMISSION FACTOR
    delete from ggircs.measured_emission_factor;
    insert into ggircs.measured_emission_factor (id, ghgr_import_id, fuel_id,
                                                 activity_name, sub_activity_name, unit_name, sub_unit_name,
                                                 measured_emission_factor_amount, measured_emission_factor_gas, measured_emission_factor_unit_type)

    select _measured_emission_factor.id, _measured_emission_factor.ghgr_import_id, _fuel.id,
           _measured_emission_factor.activity_name, _measured_emission_factor.sub_activity_name, _measured_emission_factor.unit_name, _measured_emission_factor.sub_unit_name,
           _measured_emission_factor.measured_emission_factor_amount, _measured_emission_factor.measured_emission_factor_gas, _measured_emission_factor.measured_emission_factor_unit_type

    from ggircs_swrs.measured_emission_factor as _measured_emission_factor

    inner join ggircs_swrs.final_report as _final_report on _measured_emission_factor.ghgr_import_id = _final_report.ghgr_import_id
    --FK Measured Emission Factor -> Fuel
    left join ggircs_swrs.fuel as _fuel
      on _measured_emission_factor.ghgr_import_id = _fuel.ghgr_import_id
      and _measured_emission_factor.process_idx = _fuel.process_idx
      and _measured_emission_factor.sub_process_idx = _fuel.sub_process_idx
      and _measured_emission_factor.activity_name = _fuel.activity_name
      and _measured_emission_factor.sub_activity_name = _fuel.sub_activity_name
      and _measured_emission_factor.unit_name = _fuel.unit_name
      and _measured_emission_factor.sub_unit_name = _fuel.sub_unit_name
      and _measured_emission_factor.substance_idx = _fuel.substance_idx
      and _measured_emission_factor.substances_idx = _fuel.substances_idx
      and _measured_emission_factor.sub_unit_name = _fuel.sub_unit_name
      and _measured_emission_factor.units_idx = _fuel.units_idx
      and _measured_emission_factor.unit_idx = _fuel.unit_idx
      and _measured_emission_factor.fuel_idx = _fuel.fuel_idx
      ;


    -- Refresh materialized views with no data
    perform ggircs_swrs.refresh_materialized_views('with no data');
  end;

$function$ language plpgsql volatile ;

commit;

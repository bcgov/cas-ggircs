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
  /** Create all tables from materialized views that are not being split up **/
  declare

       mv_array text[] := $$
                          {report, organisation, facility,
                          activity, unit, identifier, naics, emission,
                          final_report, fuel, permit, parent_organisation, contact,
                          address, additional_data, measured_emission_factor}
                          $$;

  begin

    -- Refresh materialized views
    for i in 1 .. array_upper(mv_array, 1)
      loop
        perform ggircs_swrs.refresh_materialized_views(quote_ident(mv_array[i]), 'with data');
      end loop;

    -- Populate tables
    -- REPORT
    delete from ggircs.report;
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

    select _report.id, _report.ghgr_import_id, source_xml, imported_at, _report.swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

    from ggircs_swrs.report as _report
    inner join ggircs_swrs.final_report as _final_report on _report.ghgr_import_id = _final_report.ghgr_import_id;

    -- ORGANISATION
    delete from ggircs.organisation;
    insert into ggircs.organisation (id, ghgr_import_id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

    select _organisation.id, _organisation.ghgr_import_id, _report.id, _organisation.swrs_organisation_id, _organisation.business_legal_name,
           _organisation.english_trade_name, _organisation.french_trade_name, _organisation.cra_business_number, _organisation.duns, _organisation.website

    from ggircs_swrs.organisation as _organisation

    inner join ggircs_swrs.final_report as _final_report on _organisation.ghgr_import_id = _final_report.ghgr_import_id
    --FK Organisation -> Report
    left join ggircs_swrs.report as _report
      on _organisation.ghgr_import_id = _report.ghgr_import_id;

    -- LFO FACILITY
    delete from ggircs.lfo_facility;
    insert into ggircs.lfo_facility (id, ghgr_import_id, organisation_id, report_id, swrs_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, _organisation.id, _report.id, _facility.swrs_facility_id, _facility.facility_name, _facility.facility_type,
           _facility.relationship_type, _facility.portability_indicator, _facility.status, _facility.latitude, _facility.longitude

    from ggircs_swrs.facility as _facility
   inner join ggircs_swrs.final_report as _final_report
        on _facility.ghgr_import_id = _final_report.ghgr_import_id
        and _facility.facility_type = 'LFO'
    -- FK Facility -> Organisation
    left join ggircs_swrs.organisation as _organisation
        on _facility.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Facility -> Report
    left join ggircs_swrs.report as _report
        on _facility.ghgr_import_id = _report.ghgr_import_id;

    -- SINGLE FACILITY
    delete from ggircs.single_facility;
    with _final_lfo_facility as (
        -- facility.id will as the parent facility FK.
        -- swrs_organisation_id and reporting_period_duration are the join constraints
        select _facility.id, _organisation.swrs_organisation_id, _report.reporting_period_duration
        from ggircs_swrs.facility as _facility
        inner join ggircs_swrs.final_report as _final_report
            on _facility.ghgr_import_id = _final_report.ghgr_import_id
            and _facility.facility_type = 'LFO'
        left join ggircs_swrs.organisation as _organisation
            on _facility.ghgr_import_id = _organisation.ghgr_import_id
        left join ggircs_swrs.report as _report
            on _facility.ghgr_import_id = _report.ghgr_import_id

    )
    insert into ggircs.single_facility (id, ghgr_import_id, organisation_id, report_id, swrs_facility_id, lfo_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, _organisation.id, _report.id, _facility.swrs_facility_id, _final_lfo_facility.id, _facility.facility_name, _facility.facility_type,
           _facility.relationship_type, _facility.portability_indicator, _facility.status, _facility.latitude, _facility.longitude

    from ggircs_swrs.facility as _facility
    inner join ggircs_swrs.final_report as _final_report on _facility.ghgr_import_id = _final_report.ghgr_import_id
        and (_facility.facility_type != 'LFO' or _facility.facility_type is null)
    -- FK Facility -> Organisation
    left join ggircs_swrs.organisation as _organisation
        on _facility.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Facility -> Report
    left join ggircs_swrs.report as _report
        on _facility.ghgr_import_id = _report.ghgr_import_id
    -- FK Single Facility -> LFO Facility
    left join _final_lfo_facility
        on _organisation.swrs_organisation_id = _final_lfo_facility.swrs_organisation_id
        and _report.reporting_period_duration = _final_lfo_facility.reporting_period_duration
        and (_facility.facility_type = 'IF_a' or _facility.facility_type = 'IF_b' or _facility.facility_type = 'L_c');

    -- ACTIVITY
    delete from ggircs.activity;
    insert into ggircs.activity (id, ghgr_import_id, single_facility_id, lfo_facility_id, report_id, activity_name, process_name, sub_process_name, information_requirement)

    select _activity.id, _activity.ghgr_import_id, _single_facility.id, _lfo_facility.id, _report.id, _activity.activity_name, _activity.process_name, _activity.sub_process_name, _activity.information_requirement

    from ggircs_swrs.activity as _activity

    inner join ggircs_swrs.final_report as _final_report on _activity.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Activity -> Single Facility
    left join ggircs_swrs.facility as _single_facility
      on _activity.ghgr_import_id = _single_facility.ghgr_import_id
      and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Activity -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
      on _activity.ghgr_import_id = _lfo_facility.ghgr_import_id
      and _lfo_facility.facility_type = 'LFO'
    -- FK Activity -> Report
    left join ggircs_swrs.report as _report
      on _activity.ghgr_import_id = _report.ghgr_import_id;

    -- UNIT
    delete from ggircs.unit;
    insert into ggircs.unit (id, ghgr_import_id, activity_id, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
                             cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
                             non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name)

    select _unit.id, _unit.ghgr_import_id, _activity.id, _unit.activity_name, _unit.unit_name, _unit.unit_description, _unit.cogen_unit_name, _unit.cogen_cycle_type,
           _unit.cogen_nameplate_capacity, _unit.cogen_net_power, _unit.cogen_steam_heat_acq_quantity, _unit.cogen_steam_heat_acq_name, _unit.cogen_supplemental_firing_purpose,
           _unit.cogen_thermal_output_quantity, _unit.non_cogen_nameplate_capacity, _unit.non_cogen_net_power, _unit.non_cogen_unit_name

    from ggircs_swrs.unit as _unit

    inner join ggircs_swrs.final_report as _final_report on _unit.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Unit -> Activity
    left join ggircs_swrs.activity as _activity
      on _unit.ghgr_import_id = _activity.ghgr_import_id
      and _unit.process_idx = _activity.process_idx
      and _unit.sub_process_idx = _activity.sub_process_idx
      and _unit.activity_name = _activity.activity_name;

    -- IDENTIFIER
    delete from ggircs.identifier;
    insert into ggircs.identifier(id, ghgr_import_id, single_facility_bcghgid_id, lfo_facility_bcghgid_id, single_facility_id, lfo_facility_id, report_id, swrs_facility_id, path_context, identifier_type, identifier_value)

    select _identifier.id, _identifier.ghgr_import_id, _single_facility_bcghgid.id, _lfo_facility_bcghgid.id, _single_facility.id, _lfo_facility.id, _report.id, _identifier.swrs_facility_id, _identifier.path_context, _identifier.identifier_type, _identifier.identifier_value

    from ggircs_swrs.identifier as _identifier

    inner join ggircs_swrs.final_report as _final_report on _identifier.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Identifier -> Single Facility
    left join ggircs_swrs.facility as _single_facility
      on _identifier.ghgr_import_id = _single_facility.ghgr_import_id
      and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Identifier -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
      on _identifier.ghgr_import_id = _lfo_facility.ghgr_import_id
      and _lfo_facility.facility_type = 'LFO'
    -- FK Identifier -> Report
    left join ggircs_swrs.report as _report
      on _identifier.ghgr_import_id = _report.ghgr_import_id
    left join ggircs.single_facility as _single_facility_bcghgid
      on _identifier.ghgr_import_id = _single_facility_bcghgid.ghgr_import_id
      and (((_identifier.path_context = 'RegistrationData'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' )

               and (select id from ggircs_swrs.identifier as __identifier
                  where __identifier.ghgr_import_id = _single_facility_bcghgid.ghgr_import_id
                  and __identifier.path_context = 'VerifyTombstone'
                  and __identifier.identifier_type = 'BCGHGID'
                  and __identifier.identifier_value is not null
                  and __identifier.identifier_value != '') is null)
          or (_identifier.path_context = 'VerifyTombstone'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' ))
    left join ggircs.lfo_facility as _lfo_facility_bcghgid
      on _identifier.ghgr_import_id = _lfo_facility_bcghgid.ghgr_import_id
      and (((_identifier.path_context = 'RegistrationData'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' )

               and (select id from ggircs_swrs.identifier as __identifier
                  where __identifier.ghgr_import_id = _lfo_facility_bcghgid.ghgr_import_id
                  and __identifier.path_context = 'VerifyTombstone'
                  and __identifier.identifier_type = 'BCGHGID'
                  and __identifier.identifier_value is not null
                  and __identifier.identifier_value != '') is null)
          or (_identifier.path_context = 'VerifyTombstone'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' ));

    -- NAICS
    delete from ggircs.naics;
    insert into ggircs.naics(id, ghgr_import_id, single_facility_id, lfo_facility_id, registration_data_single_facility_id, registration_data_lfo_facility_id, naics_mapping_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

    select _naics.id, _naics.ghgr_import_id, _single_facility.id, _lfo_facility.id,
        (select _single_facility.id where _naics.path_context = 'RegistrationData'),
        (select _lfo_facility.id where _naics.path_context = 'RegistrationData'),
        _naics_mapping.id, _report.id, _naics.swrs_facility_id,
        _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

    from ggircs_swrs.naics as _naics
    inner join ggircs_swrs.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Naics -> Single Facility
    left join ggircs_swrs.facility as _single_facility
      on _naics.ghgr_import_id = _single_facility.ghgr_import_id
      and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Naics -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
      on _naics.ghgr_import_id = _lfo_facility.ghgr_import_id
      and _lfo_facility.facility_type = 'LFO'
    -- FK Naics -> Report
    left join ggircs_swrs.report as _report
      on _naics.ghgr_import_id = _report.ghgr_import_id
    -- FK Naics -> Naics Mapping
    left join ggircs_swrs.naics_mapping as _naics_mapping
      on _naics.naics_code = _naics_mapping.naics_code;

    -- FUEL
    delete from ggircs.fuel;
    insert into ggircs.fuel(id, ghgr_import_id, report_id, unit_id, fuel_mapping_id,
                            activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                            fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                            other_flare_details, q1, q2, q3, q4, wastewater_processing_factors, measured_conversion_factors)

    select _fuel.id, _fuel.ghgr_import_id, _report.id, _unit.id, _fuel_mapping.id,
           _fuel.activity_name, _fuel.sub_activity_name, _fuel.unit_name, _fuel.sub_unit_name, _fuel.fuel_type, _fuel.fuel_classification, _fuel.fuel_description,
           _fuel.fuel_units, _fuel.annual_fuel_amount, _fuel.annual_weighted_avg_carbon_content, _fuel.annual_weighted_avg_hhv, _fuel.annual_steam_generation,
           _fuel.alternative_methodology_description, _fuel.other_flare_details, _fuel.q1, _fuel.q2, _fuel.q3, _fuel.q4, _fuel.wastewater_processing_factors, _fuel.measured_conversion_factors

    from ggircs_swrs.fuel as _fuel
    inner join ggircs_swrs.final_report as _final_report on _fuel.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Fuel -> Report
    left join ggircs_swrs.report as _report
    on _fuel.ghgr_import_id = _report.ghgr_import_id
    -- FK Fuel -> Unit
    left join ggircs_swrs.unit as _unit
      on _fuel.ghgr_import_id = _unit.ghgr_import_id
      and _fuel.process_idx = _unit.process_idx
      and _fuel.sub_process_idx = _unit.sub_process_idx
      and _fuel.activity_name = _unit.activity_name
      and _fuel.units_idx = _unit.units_idx
      and _fuel.unit_idx = _unit.unit_idx
    left join ggircs_swrs.fuel_mapping as _fuel_mapping
      on _fuel.fuel_type = _fuel_mapping.fuel_type;

    -- EMISSION
    delete from ggircs.emission;
    insert into ggircs.emission (id, ghgr_import_id, activity_id, single_facility_id, lfo_facility_id, fuel_id, naics_id, organisation_id, report_id, unit_id, fuel_mapping_id,
                                 activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_name, emission_type,
                                 gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category)

    select _emission.id, _emission.ghgr_import_id, _activity.id, _single_facility.id, _lfo_facility.id, _fuel.id, _naics.id, _organisation.id, _report.id, _unit.id, _fuel_mapping.id,
           _emission.activity_name, _emission.sub_activity_name, _emission.unit_name, _emission.sub_unit_name, _emission.fuel_name, _emission.emission_type,
           _emission.gas_type, _emission.methodology, _emission.not_applicable, _emission.quantity, _emission.calculated_quantity, _emission.emission_category

    from ggircs_swrs.emission as _emission
    -- join ggircs_swrs.emission to use _idx columns in FK creations
    inner join ggircs_swrs.final_report as _final_report on _emission.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Emission -> Activity
    left join ggircs_swrs.activity as _activity
      on _emission.ghgr_import_id = _activity.ghgr_import_id
      and _emission.process_idx = _activity.process_idx
      and _emission.sub_process_idx = _activity.sub_process_idx
      and _emission.activity_name = _activity.activity_name
    -- FK Emission -> Single Facility
    left join ggircs_swrs.facility as _single_facility
        on _emission.ghgr_import_id = _single_facility.ghgr_import_id
        and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Emission -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
        on _emission.ghgr_import_id = _lfo_facility.ghgr_import_id
        and _lfo_facility.facility_type = 'LFO'
    -- FK Emission -> Fuel
    left join ggircs_swrs.fuel as _fuel
      on _emission.ghgr_import_id = _fuel.ghgr_import_id
      and _emission.process_idx = _fuel.process_idx
      and _emission.sub_process_idx = _fuel.sub_process_idx
      and _emission.activity_name = _fuel.activity_name
      and _emission.sub_activity_name = _fuel.sub_activity_name
      and _emission.unit_name = _fuel.unit_name
      and _emission.sub_unit_name = _fuel.sub_unit_name
      and _emission.substance_idx = _fuel.substance_idx
      and _emission.substances_idx = _fuel.substances_idx
      and _emission.sub_unit_name = _fuel.sub_unit_name
      and _emission.units_idx = _fuel.units_idx
      and _emission.unit_idx = _fuel.unit_idx
      and _emission.fuel_idx = _fuel.fuel_idx
    -- FK Emission -> Naics
        -- This long join gets id for the NAICS code from RegistrationData if the code exists and is unique (1 Primary per report)
        -- If there are 2 primary NAICS codes defined in RegistrationData the id for the code is derived from VerifyTombstone
    left outer join ggircs_swrs.naics as _naics
      on  _emission.ghgr_import_id = _naics.ghgr_import_id
      and ((_naics.path_context = 'RegistrationData'
      and (_naics.naics_priority = 'Primary'
            or _naics.naics_priority = '100.00'
            or _naics.naics_priority = '100')
      and (select count(ghgr_import_id)
           from ggircs_swrs.naics as __naics
           where ghgr_import_id = _emission.ghgr_import_id
           and __naics.path_context = 'RegistrationData'
           and (__naics.naics_priority = 'Primary'
            or __naics.naics_priority = '100.00'
            or __naics.naics_priority = '100')) < 2)
       or (_naics.path_context='VerifyTombstone'
           and _naics.naics_code is not null
           and (select count(ghgr_import_id)
           from ggircs_swrs.naics as __naics
           where ghgr_import_id = _emission.ghgr_import_id
           and __naics.path_context = 'RegistrationData'
           and (__naics.naics_priority = 'Primary'
            or __naics.naics_priority = '100.00'
            or __naics.naics_priority = '100')) > 1))
    left join ggircs_swrs.fuel_mapping as _fuel_mapping
        on _fuel_mapping.fuel_type = 'Flared Natural Gas'
        and _activity.sub_process_name = 'Flaring'

    -- FK Emission -> Organisation
    left join ggircs_swrs.organisation as _organisation
      on _emission.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Emisison -> Report
    left join ggircs_swrs.report as _report
      on _emission.ghgr_import_id = _report.ghgr_import_id
    -- FK Emission -> Unit
    left join ggircs_swrs.unit as _unit
      on _emission.ghgr_import_id = _unit.ghgr_import_id
      and _emission.process_idx = _unit.process_idx
      and _emission.sub_process_idx = _unit.sub_process_idx
      and _emission.activity_name = _unit.activity_name
      and _emission.units_idx = _unit.units_idx
      and _emission.unit_idx = _unit.unit_idx;


    -- PERMIT
    delete from ggircs.permit;
    insert into ggircs.permit(id, ghgr_import_id, single_facility_id, lfo_facility_id, path_context, issuing_agency, issuing_dept_agency_program, permit_number)

    select _permit.id, _permit.ghgr_import_id, _single_facility.id, _lfo_facility.id, _permit.path_context, _permit.issuing_agency, _permit.issuing_dept_agency_program, _permit.permit_number

    from ggircs_swrs.permit as _permit

    inner join ggircs_swrs.final_report as _final_report on _permit.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Permit -> Single Facility
    left join ggircs_swrs.facility as _single_facility
        on _permit.ghgr_import_id = _single_facility.ghgr_import_id
        and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Permit -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
        on _permit.ghgr_import_id = _lfo_facility.ghgr_import_id
        and _lfo_facility.facility_type = 'LFO';

    -- PARENT ORGANISATION
    delete from ggircs.parent_organisation;
    insert into ggircs.parent_organisation (id, ghgr_import_id, report_id, organisation_id, path_context, percentage_owned, french_trade_name, english_trade_name,
                                            duns, business_legal_name, website)

    select _parent_organisation.id, _parent_organisation.ghgr_import_id, _report.id, _organisation.id, _parent_organisation.path_context, _parent_organisation.percentage_owned,
           _parent_organisation.french_trade_name, _parent_organisation.english_trade_name, _parent_organisation.duns, _parent_organisation.business_legal_name, _parent_organisation.website

    from ggircs_swrs.parent_organisation as _parent_organisation

    inner join ggircs_swrs.final_report as _final_report on _parent_organisation.ghgr_import_id = _final_report.ghgr_import_id
    --FK Parent Organisation -> Organisation
    left join ggircs_swrs.organisation as _organisation
      on _parent_organisation.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Parent Organisation -> Report
    left join ggircs_swrs.report as _report
      on _parent_organisation.ghgr_import_id = _report.ghgr_import_id;

    -- ADDRESS
    delete from ggircs.address;
    insert into ggircs.address (id, ghgr_import_id, single_facility_id, lfo_facility_id, organisation_id, parent_organisation_id, report_id, swrs_facility_id, swrs_organisation_id, path_context, type, physical_address_municipality, physical_address_unit_number,
                                physical_address_street_number, physical_address_street_number_suffix, physical_address_street_name, physical_address_street_type,
                                physical_address_street_direction, physical_address_prov_terr_state, physical_address_postal_code_zip_code, physical_address_country,
                                physical_address_national_topographical_description, physical_address_additional_information, physical_address_land_survey_description,
                                mailing_address_delivery_mode, mailing_address_po_box_number, mailing_address_unit_number, mailing_address_rural_route_number,
                                mailing_address_street_number, mailing_address_street_number_suffix, mailing_address_street_name, mailing_address_street_type,
                                mailing_address_street_direction, mailing_address_municipality, mailing_address_prov_terr_state, mailing_address_postal_code_zip_code,
                                mailing_address_country, mailing_address_additional_information, geographic_address_latitude, geographic_address_longitude)

    select _address.id, _address.ghgr_import_id, _single_facility.id, _lfo_facility.id, _organisation.id, _parent_organisation.id, _report.id, _address.swrs_facility_id, _address.swrs_organisation_id,
           _address.path_context,_address.type, _address.physical_address_municipality, _address.physical_address_unit_number,
           _address.physical_address_street_number, _address.physical_address_street_number_suffix, _address.physical_address_street_name, _address.physical_address_street_type,
           _address.physical_address_street_direction, _address.physical_address_prov_terr_state, _address.physical_address_postal_code_zip_code, _address.physical_address_country,
           _address.physical_address_national_topographical_description, _address.physical_address_additional_information, _address.physical_address_land_survey_description,
           _address.mailing_address_delivery_mode, _address.mailing_address_po_box_number, _address.mailing_address_unit_number, _address.mailing_address_rural_route_number,
           _address.mailing_address_street_number, _address.mailing_address_street_number_suffix, _address.mailing_address_street_name, _address.mailing_address_street_type,
           _address.mailing_address_street_direction, _address.mailing_address_municipality, _address.mailing_address_prov_terr_state, _address.mailing_address_postal_code_zip_code,
           _address.mailing_address_country, _address.mailing_address_additional_information, _address.geographic_address_latitude, _address.geographic_address_longitude

    from ggircs_swrs.address as _address

    inner join ggircs_swrs.final_report as _final_report on _address.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Address -> Single Facility
    left join ggircs_swrs.facility as _single_facility
        on _address.ghgr_import_id = _single_facility.ghgr_import_id
        and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Address -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
        on _address.ghgr_import_id = _lfo_facility.ghgr_import_id
        and _lfo_facility.facility_type = 'LFO'
    --FK Address -> Organisation
    left join ggircs_swrs.organisation as _organisation
      on _address.ghgr_import_id = _organisation.ghgr_import_id
      and _address.type = 'Organisation'
    -- FK Address -> Parent Organisation
    left join ggircs_swrs.parent_organisation as _parent_organisation
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
    left join ggircs_swrs.report as _report
      on _address.ghgr_import_id = _report.ghgr_import_id;

    -- CONTACT
    delete from ggircs.contact;
    insert into ggircs.contact (id, ghgr_import_id, address_id, single_facility_id, lfo_facility_id, report_id, organisation_id, path_context, contact_type, given_name, family_name, initials, telephone_number, extension_number,
                                fax_number, email_address, position, language_correspondence)

    select _contact.id, _contact.ghgr_import_id, _address.id, _single_facility.id, _lfo_facility.id, _report.id, _organisation.id, _contact.path_context, _contact.contact_type, _contact.given_name, _contact.family_name,
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
    -- FK Contact -> Single Facility
    left join ggircs_swrs.facility as _single_facility
        on _contact.ghgr_import_id = _single_facility.ghgr_import_id
        and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Contact -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
        on _contact.ghgr_import_id = _lfo_facility.ghgr_import_id
        and _lfo_facility.facility_type = 'LFO'
    --FK Contact -> Report
    left join ggircs_swrs.report as _report
      on _contact.ghgr_import_id = _report.ghgr_import_id
    left join ggircs_swrs.organisation as _organisation
        on _contact.ghgr_import_id = _organisation.ghgr_import_id;

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
      on _additional_data.ghgr_import_id = _report.ghgr_import_id;

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
      and _measured_emission_factor.fuel_idx = _fuel.fuel_idx;


    -- Refresh materialized views with no data
    for i in 1 .. array_upper(mv_array, 1)
      loop
        perform ggircs_swrs.refresh_materialized_views(quote_ident(mv_array[i]), 'with no data');
      end loop;
  end;

$function$ language plpgsql volatile ;

commit;

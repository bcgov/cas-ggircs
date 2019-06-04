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
    -- report
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id)

    select id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id

    from ggircs_swrs.report;

    -- organisation
    insert into ggircs.organisation (id, ghgr_import_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

    select id, ghgr_import_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website

    from ggircs_swrs.organisation;

    -- facility
    insert into ggircs.facility (id, ghgr_import_id, swrs_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select id, ghgr_import_id, swrs_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude

    from ggircs_swrs.facility;

    -- activity
    insert into ggircs.activity (id, ghgr_import_id, process_idx, sub_process_idx, activity_name, process_name, sub_process_name, information_requirement)

    select id, ghgr_import_id,  process_idx, sub_process_idx, activity_name, process_name, sub_process_name, information_requirement

    from ggircs_swrs.activity;

    -- unit
    insert into ggircs.unit (id, ghgr_import_id, process_idx, sub_process_idx, units_idx, unit_idx, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
                             cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
                             non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name)

    select id, ghgr_import_id,  process_idx, sub_process_idx, units_idx, unit_idx, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
           cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
           non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name

    from ggircs_swrs.unit;

    -- identifier
    insert into ggircs.identifier(id, ghgr_import_id, identifier_idx, swrs_facility_id, path_context, identifier_type, identifier_value)

    select id, ghgr_import_id, identifier_idx, swrs_facility_id, path_context, identifier_type, identifier_value

    from ggircs_swrs.identifier;

    -- naics
    insert into ggircs.naics(id, ghgr_import_id, naics_code_idx, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

    select id, ghgr_import_id, naics_code_idx, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority

    from ggircs_swrs.naics;

    -- emission
    insert into ggircs.emission (id, ghgr_import_id, activity_id, activity_name, sub_activity_name,
                                 unit_name, sub_unit_name, fuel_name, emission_type,
                                 gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category)

    select id, ghgr_import_id, _activity.activity_id, activity_name, sub_activity_name,
           unit_name, sub_unit_name, fuel_name, emission_type,
           gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category

    left join ggircs_swrs.emission as _emission on emission.emission_id = _emission.emission_id
    left join ggircs_swrs.activity as _activity
      on _emission.ghgr_import_id = _activity.ghgr_import_id
      and _emission.process_idx = _activity.process_idx
      and _emission.sub_process_idx = _activity.sub_process_idx
      and _emission.activity_name = _activity.activity_name

    from ggircs_swrs.emission;

    -- final_report
    insert into ggircs.final_report (id, ghgr_import_id, swrs_report_id)

    select id, ghgr_import_id, swrs_report_id

    from ggircs_swrs.final_report;

    -- fuel
    insert into ggircs.fuel(id, ghgr_import_id, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx,
                            fuel_idx, activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                            fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                            other_flare_details, q1, q2, q3, q4, wastewater_processing_factors, measured_conversion_factors)

    select id, ghgr_import_id, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx,
           fuel_idx, activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
           fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
           other_flare_details, q1, q2, q3, q4, wastewater_processing_factors, measured_conversion_factors

    from ggircs_swrs.fuel;

    -- permit

    insert into ggircs.permit(id, ghgr_import_id, permit_idx, path_context, issuing_agency, issuing_dept_agency_program, permit_number)

    select id, ghgr_import_id, permit_idx, path_context, issuing_agency, issuing_dept_agency_program, permit_number

    from ggircs_swrs.permit;

    -- parent_organisation
    insert into ggircs.parent_organisation (id, ghgr_import_id, parent_organisation_idx, path_context, percentage_owned, french_trade_name, english_trade_name,
                                            duns, business_legal_name, website)

    select id, ghgr_import_id, parent_organisation_idx, path_context, percentage_owned, french_trade_name, english_trade_name,
           duns, business_legal_name, website

    from ggircs_swrs.parent_organisation;

    -- contact
    insert into ggircs.contact (id, ghgr_import_id, contact_idx, path_context, contact_type, given_name, family_name, initials, telephone_number, extension_number,
                                fax_number, email_address, position, language_correspondence)

    select id, ghgr_import_id, contact_idx, path_context, contact_type, given_name, family_name, initials, telephone_number, extension_number,
           fax_number, email_address, position, language_correspondence

    from ggircs_swrs.contact;

    -- address
    insert into ggircs.address (id, ghgr_import_id, contact_idx, parent_organisation_idx, swrs_facility_id, swrs_organisation_id, path_context, type, physical_address_municipality, physical_address_unit_number,
                                physical_address_street_number, physical_address_street_number_suffix, physical_address_street_name, physical_address_street_type,
                                physical_address_street_direction, physical_address_prov_terr_state, physical_address_postal_code_zip_code, physical_address_country,
                                physical_address_national_topographical_description, physical_address_additional_information, physical_address_land_survey_description,
                                mailing_address_delivery_mode, mailing_address_po_box_number, mailing_address_unit_number, mailing_address_rural_route_number,
                                mailing_address_street_number, mailing_address_street_number_suffix, mailing_address_street_name, mailing_address_street_type,
                                mailing_address_street_direction, mailing_address_municipality, mailing_address_prov_terr_state, mailing_address_postal_code_zip_code,
                                mailing_address_country, mailing_address_additional_information, geographic_address_latitude, geographic_address_longitude)

    select id, ghgr_import_id, contact_idx, parent_organisation_idx, swrs_facility_id, swrs_organisation_id, path_context, type, physical_address_municipality, physical_address_unit_number,
           physical_address_street_number, physical_address_street_number_suffix, physical_address_street_name, physical_address_street_type,
           physical_address_street_direction, physical_address_prov_terr_state, physical_address_postal_code_zip_code, physical_address_country,
           physical_address_national_topographical_description, physical_address_additional_information, physical_address_land_survey_description,
           mailing_address_delivery_mode, mailing_address_po_box_number, mailing_address_unit_number, mailing_address_rural_route_number,
           mailing_address_street_number, mailing_address_street_number_suffix, mailing_address_street_name, mailing_address_street_type,
           mailing_address_street_direction, mailing_address_municipality, mailing_address_prov_terr_state, mailing_address_postal_code_zip_code,
           mailing_address_country, mailing_address_additional_information, geographic_address_latitude, geographic_address_longitude

    from ggircs_swrs.address;

    -- additional_data
    insert into ggircs.additional_data (id, ghgr_import_id, process_idx, sub_process_idx, grandparent_idx, parent_idx,
                                   class_idx, activity_name, grandparent, parent, class, attribute, attr_value, node_value)

    select id, ghgr_import_id, process_idx, sub_process_idx, grandparent_idx, parent_idx,
           class_idx, activity_name, grandparent, parent, class, attribute, attr_value, node_value

    from ggircs_swrs.additional_data;

    -- measured_emission_factor
    insert into ggircs.measured_emission_factor (id, ghgr_import_id, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx,
                                                 fuel_idx, measured_emission_factor_idx, activity_name, sub_activity_name, unit_name, sub_unit_name,
                                                 measured_emission_factor_amount, measured_emission_factor_gas, measured_emission_factor_unit_type)

    select id, ghgr_import_id, process_idx, sub_process_idx, units_idx, unit_idx, substances_idx, substance_idx,
           fuel_idx, measured_emission_factor_idx, activity_name, sub_activity_name, unit_name, sub_unit_name,
           measured_emission_factor_amount, measured_emission_factor_gas, measured_emission_factor_unit_type

    from ggircs_swrs.measured_emission_factor;

    -- attributable emission
    raise notice 'Exporting attributable_emission';

    execute
      'drop table if exists ggircs.attributable_emission';

    execute

          $$
          create table ggircs.attributable_emission
          as (select x.* from ggircs_swrs.emission
          as x inner join ggircs_swrs.final_report as final_report
          on x.ghgr_import_id = final_report.ghgr_import_id
          join ggircs_swrs.facility as facility
          on x.ghgr_import_id = facility.ghgr_import_id
          join ggircs_swrs.activity as activity
          on x.ghgr_import_id = activity.ghgr_import_id
          and x.process_idx = activity.process_idx
          and x.sub_process_idx = activity.sub_process_idx
          and x.activity_name = activity.activity_name
          and x.gas_type != 'CO2bioC'
          and facility.facility_type != 'EIO'
          and facility.facility_type != 'LFO'
          and activity.sub_process_name not in  ('Additional Reportable Information as per WCI.352(i)(1)-(12)',
                                   'Additional Reportable Information as per WCI.352(i)(13)',
                                   'Additional Reportable Information as per WCI.362(g)(21)',
                                   'Additional information for cement and lime production facilities only (not aggregated in totals)',
                                   'Additional information for cement and lime production facilities only (not aggregated intotals)',
                                   'Additional information required when other activities selected are Activities in Table 2 rows 2, 4, 5 , or 6',
                                   'Additional reportable information')
          )$$;

    execute 'alter table ggircs.attributable_emission add column id int generated always as identity primary key';
    
    /** Emission FKs**/
      -- Create FK/PK relation between Emission and Activity
      alter table ggircs.emission add column activity_id int;
      create index ggircs_emission_activity_index on ggircs.emission (activity_id);
      update ggircs.emission set activity_id = activity.id from ggircs.activity
          where emission.ghgr_import_id = activity.ghgr_import_id
            and emission.process_idx = activity.process_idx
            and emission.sub_process_idx = activity.sub_process_idx
            and emission.activity_name = activity.activity_name;
      alter table ggircs.emission add constraint ggircs_emission_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Emission and Fuel
      alter table ggircs.emission add column fuel_id int;
      create index ggircs_emission_fuel_index on ggircs.emission (fuel_id);
      update ggircs.emission set fuel_id = fuel.id from ggircs.fuel
          where emission.ghgr_import_id = fuel.ghgr_import_id
            and emission.process_idx = fuel.process_idx
            and emission.sub_process_idx = fuel.sub_process_idx
            and emission.activity_name = fuel.activity_name
            and emission.sub_activity_name = fuel.sub_activity_name
            and emission.unit_name = fuel.unit_name
            and emission.sub_unit_name = fuel.sub_unit_name
            and emission.substance_idx = fuel.substance_idx
            and emission.substances_idx = fuel.substances_idx
            and emission.sub_unit_name = fuel.sub_unit_name
            and emission.units_idx = fuel.units_idx
            and emission.unit_idx = fuel.unit_idx
            and emission.fuel_idx = fuel.fuel_idx;
      alter table ggircs.emission add constraint ggircs_emission_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);

      -- Create FK/PK relation between_Emission and NAICS
      alter table ggircs.emission add column naics_id int;
      create index ggircs_emission_naics_index on ggircs.emission (naics_id);
      update ggircs.emission set naics_id = naics.id from ggircs.naics
          where emission.ghgr_import_id = naics.ghgr_import_id
          and naics.path_context = 'RegistrationData';
      alter table ggircs.emission add constraint ggircs_emission_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

      -- Create FK/PK relation between_Emission and Organisation
      alter table ggircs.emission add column organisation_id int;
      create index ggircs_emission_organisation_index on ggircs.emission (organisation_id);
      update ggircs.emission set organisation_id = organisation.id from ggircs.organisation
          where emission.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between_Emission and Report
      alter table ggircs.emission add column report_id int;
      create index ggircs_emission_report_index on ggircs.emission (report_id);
      update ggircs.emission set report_id = report.id from ggircs.report
          where emission.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between_Emission and Unit
      alter table ggircs.emission add column unit_id int;
      create index ggircs_emission_unit_index on ggircs.emission (unit_id);
      update ggircs.emission set unit_id = unit.id from ggircs.unit
          where emission.ghgr_import_id = unit.ghgr_import_id
            and emission.process_idx = unit.process_idx
            and emission.sub_process_idx = unit.sub_process_idx
            and emission.activity_name = unit.activity_name
            and emission.units_idx = unit.units_idx
            and emission.unit_idx = unit.unit_idx;
      alter table ggircs.emission add constraint ggircs_emission_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

        /** Attributable Emission FKs**/
      -- Create FK/PK relation between Attributable_Emission and Activity
      alter table ggircs.attributable_emission add column activity_id int;
      create index ggircs_attributable_emission_activity_index on ggircs.attributable_emission (activity_id);
      update ggircs.attributable_emission set activity_id = activity.id from ggircs.activity
          where attributable_emission.ghgr_import_id = activity.ghgr_import_id
            and attributable_emission.process_idx = activity.process_idx
            and attributable_emission.sub_process_idx = activity.sub_process_idx
            and attributable_emission.activity_name = activity.activity_name;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Attributable_Emission and Fuel
      alter table ggircs.attributable_emission add column fuel_id int;
      create index ggircs_attributable_emission_fuel_index on ggircs.attributable_emission (fuel_id);
      update ggircs.attributable_emission set fuel_id = fuel.id from ggircs.fuel
          where attributable_emission.ghgr_import_id = fuel.ghgr_import_id
            and attributable_emission.process_idx = fuel.process_idx
            and attributable_emission.sub_process_idx = fuel.sub_process_idx
            and attributable_emission.activity_name = fuel.activity_name
            and attributable_emission.sub_activity_name = fuel.sub_activity_name
            and attributable_emission.unit_name = fuel.unit_name
            and attributable_emission.sub_unit_name = fuel.sub_unit_name
            and attributable_emission.substance_idx = fuel.substance_idx
            and attributable_emission.substances_idx = fuel.substances_idx
            and attributable_emission.sub_unit_name = fuel.sub_unit_name
            and attributable_emission.units_idx = fuel.units_idx
            and attributable_emission.unit_idx = fuel.unit_idx
            and attributable_emission.fuel_idx = fuel.fuel_idx;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);

      -- Create FK/PK relation between Attributable_Emission and NAICS
      alter table ggircs.attributable_emission add column naics_id int;
      create index ggircs_attributable_emission_naics_index on ggircs.attributable_emission (naics_id);
      update ggircs.attributable_emission set naics_id = naics.id from ggircs.naics
          where attributable_emission.ghgr_import_id = naics.ghgr_import_id
          and naics.path_context = 'RegistrationData';
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

      -- Create FK/PK relation between Attributable_Emission and Organisation
      alter table ggircs.attributable_emission add column organisation_id int;
      create index ggircs_attributable_emission_organisation_index on ggircs.attributable_emission (organisation_id);
      update ggircs.attributable_emission set organisation_id = organisation.id from ggircs.organisation
          where attributable_emission.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);
-- --
      -- Create FK/PK relation between Attributable_Emission and Report
      alter table ggircs.attributable_emission add column report_id int;
      create index ggircs_attributable_emission_report_index on ggircs.attributable_emission (report_id);
      update ggircs.attributable_emission set report_id = report.id from ggircs.report
          where attributable_emission.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_report_foreign_key foreign key (report_id) references ggircs.report(id);
-- --
      -- Create FK/PK relation between Attributable_Emission and Unit
      alter table ggircs.attributable_emission add column unit_id int;
      create index ggircs_attributable_emission_unit_index on ggircs.attributable_emission (unit_id);
      update ggircs.attributable_emission set unit_id = unit.id from ggircs.unit
          where attributable_emission.ghgr_import_id = unit.ghgr_import_id
            and attributable_emission.process_idx = unit.process_idx
            and attributable_emission.sub_process_idx = unit.sub_process_idx
            and attributable_emission.activity_name = unit.activity_name
            and attributable_emission.units_idx = unit.units_idx
            and attributable_emission.unit_idx = unit.unit_idx;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);
-- --
    /** FACILITY FKs**/
      -- Create FK/PK relation between Attributable_Emission and Facility
      alter table ggircs.attributable_emission add column facility_id int;
      create index ggircs_attributable_emission_facility_index on ggircs.attributable_emission (facility_id);
      update ggircs.attributable_emission set facility_id = facility.id from ggircs.facility
          where attributable_emission.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.attributable_emission add constraint ggircs_attributable_emission_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Emission and Facility
      alter table ggircs.emission add column facility_id int;
      create index ggircs_emission_facility_index on ggircs.emission (facility_id);
      update ggircs.emission set facility_id = facility.id from ggircs.facility
          where emission.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.emission add constraint ggircs_emission_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Facility and Report
      alter table ggircs.facility add column report_id int;
      create index ggircs_facility_report_index on ggircs.facility (report_id);
      update ggircs.facility set report_id = report.id from ggircs.report
          where facility.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.facility add constraint ggircs_facility_report_foreign_key foreign key (report_id) references ggircs.report(id);

     -- Create FK/PK relation between Address and Facility
      alter table ggircs.address add column facility_id int;
      create index ggircs_address_facility_index on ggircs.address (facility_id);
      update ggircs.address set facility_id = facility.id from ggircs.facility
          where address.ghgr_import_id = facility.ghgr_import_id
          and address.type = 'Facility';
      alter table ggircs.address add constraint ggircs_address_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

     -- Create FK/PK relation between Contact and Facility
      alter table ggircs.contact add column facility_id int;
      create index ggircs_contact_facility_index on ggircs.contact (facility_id);
      update ggircs.contact set facility_id = facility.id from ggircs.facility
          where contact.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.contact add constraint ggircs_contact_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Identifier and Facility
      alter table ggircs.identifier add column facility_id int;
      create index ggircs_identifier_facility_index on ggircs.identifier (facility_id);
      update ggircs.identifier set facility_id = facility.id from ggircs.facility
          where identifier.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.identifier add constraint ggircs_identifier_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between NAICS and Facility
      alter table ggircs.naics add column facility_id int;
      create index ggircs_naics_facility_index on ggircs.naics (facility_id);
      update ggircs.naics set facility_id = facility.id from ggircs.facility
          where naics.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.naics add constraint ggircs_naics_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Permit and Facility
      alter table ggircs.permit add column facility_id int;
      create index ggircs_permit_facility_index on ggircs.permit (facility_id);
      update ggircs.permit set facility_id = facility.id from ggircs.facility
          where permit.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.permit add constraint ggircs_permit_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Activity and Facility
      alter table ggircs.activity add column facility_id int;
      create index ggircs_activity_facility_index on ggircs.activity (facility_id);
      update ggircs.activity set facility_id = facility.id from ggircs.facility
          where activity.ghgr_import_id = facility.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_facility_foreign_key foreign key (facility_id) references ggircs.facility(id);

      -- Create FK/PK relation between Facility and Organisation
      alter table ggircs.facility add column organisation_id int;
      create index ggircs_facility_organisation_index on ggircs.facility (organisation_id);
      update ggircs.facility set organisation_id = organisation.id from ggircs.organisation
          where facility.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.facility add constraint ggircs_facility_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);
    
      -- Create FK/PK relation between Facility and Identifier (BCGHGID)
      alter table ggircs.facility add column identifier_id int;
      create index ggircs_facility_identifier_index on ggircs.facility (identifier_id);

      with x as (select * from ggircs.identifier where identifier_type = 'BCGHGID' and identifier_value is not null and identifier_value != '' order by path_context desc)
      update ggircs.facility as f set identifier_id = x.id from x where f.ghgr_import_id = x.ghgr_import_id;

      alter table ggircs.facility add constraint ggircs_facility_identifier_foreign_key foreign key (identifier_id) references ggircs.identifier(id);

      -- Create FK/PK relation between Facility and Naics (naics_code / classification)
      alter table ggircs.facility add column naics_id int;
      create index ggircs_facility_naics_index on ggircs.facility (naics_id);
      -- Only keying on path_context = 'RegistrationData', VerifyTombstone does not have classification
      with x as (select * from ggircs.naics where path_context = 'RegistrationData')
      update ggircs.facility as f set naics_id = x.id from x where f.ghgr_import_id = x.ghgr_import_id;
      alter table ggircs.facility add constraint ggircs_facility_naics_foreign_key foreign key (naics_id) references ggircs.naics(id);

    /** Remaining FK's **/
      -- Create FK/PK relation between Activity and Report
      alter table ggircs.activity add column report_id int;
      create index ggircs_activity_report_index on ggircs.activity (report_id);
      update ggircs.activity set report_id = report.id from ggircs.report
          where activity.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.activity add constraint ggircs_activity_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Address and Report
      alter table ggircs.address add column report_id int;
      create index ggircs_address_report_index on ggircs.address (report_id);
      update ggircs.address set report_id = report.id from ggircs.report
          where address.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.address add constraint ggircs_address_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Contact and Report
      alter table ggircs.contact add column report_id int;
      create index ggircs_contact_report_index on ggircs.contact (report_id);
      update ggircs.contact set report_id = report.id from ggircs.report
          where contact.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.contact add constraint ggircs_contact_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Parent Organisation and Report
      alter table ggircs.parent_organisation add column report_id int;
      create index ggircs_parent_organisation_report_index on ggircs.parent_organisation (report_id);
      update ggircs.parent_organisation set report_id = report.id from ggircs.report
          where parent_organisation.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.parent_organisation add constraint ggircs_parent_organisation_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Descriptor and Report
      alter table ggircs.additional_data add column report_id int;
      create index ggircs_additional_data_report_index on ggircs.additional_data (report_id);
      update ggircs.additional_data set report_id = report.id from ggircs.report
          where additional_data.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.additional_data add constraint ggircs_additional_data_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Fuel and Report
      alter table ggircs.fuel add column report_id int;
      create index ggircs_fuel_report_index on ggircs.fuel (report_id);
      update ggircs.fuel set report_id = report.id from ggircs.report
          where fuel.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.fuel add constraint ggircs_fuel_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Naics and Report
      alter table ggircs.naics add column report_id int;
      create index ggircs_naics_report_index on ggircs.naics (report_id);
      update ggircs.naics set report_id = report.id from ggircs.report
          where naics.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.naics add constraint ggircs_naics_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Identifier and Report
      alter table ggircs.identifier add column report_id int;
      create index ggircs_identifier_report_index on ggircs.identifier (report_id);
      update ggircs.identifier set report_id = report.id from ggircs.report
          where identifier.ghgr_import_id = report.ghgr_import_id;
      alter table ggircs.identifier add constraint ggircs_identifier_report_foreign_key foreign key (report_id) references ggircs.report(id);

      -- Create FK/PK relation between Address and Organisation
      alter table ggircs.address add column organisation_id int;
      create index ggircs_address_organisation_index on ggircs.address (organisation_id);
      update ggircs.address set organisation_id = organisation.id from ggircs.organisation
          where address.ghgr_import_id = organisation.ghgr_import_id
          and address.type = 'Organisation';
      alter table ggircs.address add constraint ggircs_address_organisation_foreign_key foreign key (organisation_id) references ggircs.organisation(id);

      -- Create FK/PK relation between Address and parent_organisation
      alter table ggircs.address add column parent_organisation_id int;
      create index ggircs_address_parent_organisation_index on ggircs.address (parent_organisation_id);
      update ggircs.address set parent_organisation_id = parent_organisation.id from ggircs.parent_organisation
        where address.ghgr_import_id = parent_organisation.ghgr_import_id
      and address.type = 'ParentOrganisation'
      and address.parent_organisation_idx = parent_organisation.parent_organisation_idx;
      alter table ggircs.address add constraint ggircs_address_parent_organisation_foreign_key foreign key (parent_organisation_id) references ggircs.parent_organisation(id);

      -- Create FK/PK relation between Contact and Address
      alter table ggircs.contact add column address_id int;
      create index ggircs_contact_address_index on ggircs.contact (address_id);
      update ggircs.contact set address_id = address.id from ggircs.address
          where address.ghgr_import_id = contact.ghgr_import_id
          and   address.type = 'Contact'
          and   address.contact_idx = contact.contact_idx;
      alter table ggircs.contact add constraint ggircs_contact_address_foreign_key foreign key (address_id) references ggircs.address(id);

      -- Create FK/PK relation between Descriptor and Activity
      alter table ggircs.additional_data add column activity_id int;
      create index ggircs_additional_data_activity_index on ggircs.additional_data (activity_id);
      update ggircs.additional_data set activity_id = activity.id from ggircs.activity
          where additional_data.ghgr_import_id = activity.ghgr_import_id
            and additional_data.process_idx = activity.process_idx
            and additional_data.sub_process_idx = activity.sub_process_idx
            and additional_data.activity_name = activity.activity_name;
      alter table ggircs.additional_data add constraint ggircs_additional_data_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Fuel and Unit
      alter table ggircs.fuel add column unit_id int;
      create index ggircs_fuel_unit_index on ggircs.fuel (unit_id);
      update ggircs.fuel set unit_id = unit.id from ggircs.unit
          where fuel.ghgr_import_id = unit.ghgr_import_id and fuel.process_idx = unit.process_idx  and fuel.sub_process_idx = unit.sub_process_idx
            and fuel.activity_name = unit.activity_name and fuel.units_idx = unit.units_idx and fuel.unit_idx = unit.unit_idx;
      alter table ggircs.fuel add constraint ggircs_fuel_unit_foreign_key foreign key (unit_id) references ggircs.unit(id);

    -- Create FK/PK relation between Organisation and Parent Organisation
      alter table ggircs.organisation add column parent_organisation_id int;
      create index ggircs_organisation_parent_organisation_index on ggircs.organisation (parent_organisation_id);
      update ggircs.organisation set parent_organisation_id = parent_organisation.id from ggircs.parent_organisation
          where parent_organisation.ghgr_import_id = organisation.ghgr_import_id;
      alter table ggircs.organisation add constraint ggircs_organisation_parent_organisation_foreign_key foreign key (parent_organisation_id) references ggircs.parent_organisation(id);

      -- Create FK/PK relation between Unit and Activity
      alter table ggircs.unit add column activity_id int;
      create index ggircs_unit_activity_index on ggircs.unit (activity_id);
      update ggircs.unit set activity_id = activity.id from ggircs.activity
          where unit.ghgr_import_id = activity.ghgr_import_id
            and unit.process_idx = activity.process_idx
            and unit.sub_process_idx = activity.sub_process_idx
            and unit.activity_name = activity.activity_name;
      alter table ggircs.unit add constraint ggircs_unit_activity_foreign_key foreign key (activity_id) references ggircs.activity(id);

      -- Create FK/PK relation between Measured_Emission_Factor and Fuel
      alter table ggircs.measured_emission_factor add column fuel_id int;
      create index ggircs_measured_emission_factor_fuel_index on ggircs.measured_emission_factor (fuel_id);
      update ggircs.measured_emission_factor set fuel_id = fuel.id from ggircs.fuel
          where measured_emission_factor.ghgr_import_id = fuel.ghgr_import_id
            and measured_emission_factor.process_idx = fuel.process_idx
            and measured_emission_factor.sub_process_idx = fuel.sub_process_idx
            and measured_emission_factor.activity_name = fuel.activity_name
            and measured_emission_factor.sub_activity_name = fuel.sub_activity_name
            and measured_emission_factor.unit_name = fuel.unit_name
            and measured_emission_factor.sub_unit_name = fuel.sub_unit_name
            and measured_emission_factor.substance_idx = fuel.substance_idx
            and measured_emission_factor.substances_idx = fuel.substances_idx
            and measured_emission_factor.sub_unit_name = fuel.sub_unit_name
            and measured_emission_factor.units_idx = fuel.units_idx
            and measured_emission_factor.unit_idx = fuel.unit_idx
            and measured_emission_factor.fuel_idx = fuel.fuel_idx;
      alter table ggircs.measured_emission_factor add constraint ggircs_measured_emission_factor_fuel_foreign_key foreign key (fuel_id) references ggircs.fuel(id);

    -- Create FK/PK relation between naics and ggircs_swrs.naics_mapping
      alter table ggircs.naics add column naics_mapping_id int;
      create index ggircs_naics_naics_mapping_index on ggircs.naics (naics_mapping_id);
      update ggircs.naics set naics_mapping_id = naics_mapping.id from ggircs_swrs.naics_mapping
          where naics.naics_code = naics_mapping.naics_code;
      alter table ggircs.naics add constraint ggircs_swrs_naics_naics_mapping_foreign_key foreign key (naics_mapping_id) references ggircs_swrs.naics_mapping(id);

    -- Refresh materialized views with no data
    for i in 1 .. array_upper(mv_array, 1)
      loop
        perform ggircs_swrs.refresh_materialized_views(quote_ident(mv_array[i]), 'with no data');
      end loop;

    -- drop unwanted tables from the ggircs namespace
    alter table ggircs.activity drop column process_idx, drop column sub_process_idx;
    alter table ggircs.address drop column contact_idx, drop column parent_organisation_idx;
    alter table ggircs.contact drop column contact_idx;
    alter table ggircs.additional_data
        drop column process_idx,
        drop column sub_process_idx,
        drop column grandparent_idx,
        drop column parent_idx,
        drop column class_idx;
    alter table ggircs.emission
        drop column process_idx,
        drop column sub_process_idx,
        drop column units_idx,
        drop column unit_idx,
        drop column substances_idx,
        drop column substance_idx,
        drop column fuel_idx,
        drop column emissions_idx,
        drop column emission_idx;
    alter table ggircs.fuel
        drop column process_idx,
        drop column sub_process_idx,
        drop column units_idx,
        drop column unit_idx,
        drop column substances_idx,
        drop column substance_idx,
        drop column fuel_idx;
    alter table ggircs.identifier drop column identifier_idx;
    alter table ggircs.measured_emission_factor
        drop column process_idx,
        drop column sub_process_idx,
        drop column units_idx,
        drop column unit_idx,
        drop column substances_idx,
        drop column substance_idx,
        drop column fuel_idx,
        drop column measured_emission_factor_idx;
    alter table ggircs.naics drop column naics_code_idx;
    alter table ggircs.parent_organisation drop column parent_organisation_idx;
    alter table ggircs.permit drop column permit_idx;
    alter table ggircs.unit
        drop column process_idx,
        drop column sub_process_idx,
        drop column units_idx,
        drop column unit_idx;
  end;

$function$ language plpgsql volatile ;

commit;

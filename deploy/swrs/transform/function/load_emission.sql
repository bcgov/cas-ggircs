-- Deploy ggircs:function_load_emission to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_facility
-- requires: materialized_view_activity
-- requires: materialized_view_unit
-- requires: materialized_view_naics
-- requires: materialized_view_fuel
-- requires: materialized_view_final_report
-- requires: table_fuel_mapping
-- requires: materialized_view_emission

begin;

create or replace function swrs_transform.load_emission()
  returns void as
$function$
    begin

        delete from swrs_load.emission;

        create temporary table all_emissions(
          id serial,
          eccc_xml_file_id int,
          activity_name varchar(1000),
          sub_activity_name varchar(1000),
          unit_name varchar(1000),
          sub_unit_name varchar(1000),
          process_idx integer,
          sub_process_idx integer,
          units_idx integer,
          unit_idx integer,
          substances_idx integer,
          substance_idx integer,
          fuel_idx integer,
          fuel_name varchar(1000),
          emissions_idx integer,
          emission_idx integer,
          emission_type varchar(1000),
          gas_type varchar(1000),
          methodology varchar(1000),
          not_applicable boolean,
          quantity numeric,
          calculated_quantity numeric,
          emission_category varchar(1000),
          cas_number varchar(1000)
        ) on commit drop;

        insert into all_emissions(
            eccc_xml_file_id,
            activity_name,
            sub_activity_name,
            unit_name,
            sub_unit_name,
            process_idx,
            sub_process_idx,
            units_idx,
            unit_idx,
            substances_idx,
            substance_idx,
            fuel_idx,
            fuel_name,
            emissions_idx,
            emission_idx,
            emission_type,
            gas_type,
            methodology,
            not_applicable,
            quantity,
            calculated_quantity,
            emission_category)
          select eccc_xml_file_id, activity_name, sub_activity_name, unit_name, sub_unit_name, process_idx, sub_process_idx,
                 units_idx, unit_idx, substances_idx, substance_idx, fuel_idx, fuel_name, emissions_idx, emission_idx,
                 emission_type, gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category
          from swrs_transform.emission;

        insert into all_emissions(
          eccc_xml_file_id,
          activity_name,
          emissions_idx,
          emission_idx,
          gas_type,
          quantity,
          calculated_quantity,
          cas_number
        ) select
          eccc_xml_file_id,
          activity_name,
          emissions_idx,
          emission_idx,
          gas_type,
          quantity,
          calculated_quantity,
          cas_number
        from swrs_transform.r3_emission;


        insert into swrs_load.emission (id, eccc_xml_file_id, activity_id, facility_id,  fuel_id, naics_id, fuel_mapping_id, organisation_id, report_id, unit_id, activity_name, sub_activity_name,
                                     unit_name, sub_unit_name, fuel_name, emission_type,
                                     gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category, cas_number)

        select _emission.id, _emission.eccc_xml_file_id, _activity.id, _facility.id,  _fuel.id, _naics.id, _fuel_mapping.id, _organisation.id, _report.id, _unit.id,
               _emission.activity_name, _emission.sub_activity_name, _emission.unit_name, _emission.sub_unit_name, _emission.fuel_name, _emission.emission_type,
               _emission.gas_type, _emission.methodology, _emission.not_applicable, _emission.quantity, _emission.calculated_quantity, _emission.emission_category, _emission.cas_number

        from all_emissions as _emission
        -- join swrs_transform.emission to use _idx columns in FK creations
        inner join swrs_transform.final_report as _final_report on _emission.eccc_xml_file_id = _final_report.eccc_xml_file_id
        -- FK Emission -> Activity
        left join swrs_transform.activity as _activity
          on _emission.eccc_xml_file_id = _activity.eccc_xml_file_id
          and _emission.process_idx = _activity.process_idx
          and _emission.sub_process_idx = _activity.sub_process_idx
          and _emission.activity_name = _activity.activity_name
        -- FK Emission -> Facility
        left join swrs_transform.facility as _facility
            on _emission.eccc_xml_file_id = _facility.eccc_xml_file_id
        -- FK Emission -> Fuel
        left join swrs_transform.fuel as _fuel
          on _emission.eccc_xml_file_id = _fuel.eccc_xml_file_id
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
        left outer join swrs_transform.naics as _naics
          on  _emission.eccc_xml_file_id = _naics.eccc_xml_file_id
          and ((_naics.path_context = 'RegistrationData'
          and (_naics.naics_priority = 'Primary'
                or _naics.naics_priority = '100.00'
                or _naics.naics_priority = '100')
          and (select count(eccc_xml_file_id)
               from swrs_transform.naics as __naics
               where eccc_xml_file_id = _emission.eccc_xml_file_id
               and __naics.path_context = 'RegistrationData'
               and (__naics.naics_priority = 'Primary'
                or __naics.naics_priority = '100.00'
                or __naics.naics_priority = '100')) < 2)
           or (_naics.path_context='VerifyTombstone'
               and _naics.naics_code is not null
               and (select count(eccc_xml_file_id)
               from swrs_transform.naics as __naics
               where eccc_xml_file_id = _emission.eccc_xml_file_id
               and __naics.path_context = 'RegistrationData'
               and (__naics.naics_priority = 'Primary'
                or __naics.naics_priority = '100.00'
                or __naics.naics_priority = '100')) > 1))
        -- FK Emission -> Fuel Mapping
        left join swrs_load.fuel_mapping as _fuel_mapping
            on ((_fuel_mapping.fuel_type = 'Flared Natural Gas CO2'
                and _activity.sub_process_name = 'Flaring'
                and _emission.gas_type like 'CO2%')
            or (_fuel_mapping.fuel_type = 'Flared Natural Gas CH4'
                and _activity.sub_process_name = 'Flaring'
                and _emission.gas_type = 'CH4')
            or (_fuel_mapping.fuel_type = 'Flared Natural Gas N2O'
                and _activity.sub_process_name = 'Flaring'
                and _emission.gas_type = 'N2O')
            or (_fuel_mapping.fuel_type = 'Vented Natural Gas CH4'
                and _emission.gas_type = 'CH4'
                and _emission.emission_type
                    in ((select taxed_emission_type from swrs_load.taxed_venting_emission_type))
                )
            )
        -- FK Emission -> Organisation
        left join swrs_transform.organisation as _organisation
          on _emission.eccc_xml_file_id = _organisation.eccc_xml_file_id
        -- FK Emisison -> Report
        left join swrs_transform.report as _report
          on _emission.eccc_xml_file_id = _report.eccc_xml_file_id
        -- FK Emission -> Unit
        left join swrs_transform.unit as _unit
          on _emission.eccc_xml_file_id = _unit.eccc_xml_file_id
          and _emission.process_idx = _unit.process_idx
          and _emission.sub_process_idx = _unit.sub_process_idx
          and _emission.activity_name = _unit.activity_name
          and _emission.units_idx = _unit.units_idx
          and _emission.unit_idx = _unit.unit_idx;

    end
$function$ language plpgsql volatile;

commit;

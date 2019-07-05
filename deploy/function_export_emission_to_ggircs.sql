-- Deploy ggircs:function_export_emission_to_ggircs to pg
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

create or replace function ggircs_swrs.export_emission_to_ggircs()
  returns void as
$function$
    begin

        delete from ggircs.emission;
        insert into ggircs.emission (id, ghgr_import_id, activity_id, facility_id,  fuel_id, naics_id, organisation_id, report_id, unit_id, activity_name, sub_activity_name,
                                     unit_name, sub_unit_name, fuel_name, emission_type,
                                     gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category)

        select _emission.id, _emission.ghgr_import_id, _activity.id, _facility.id,  _fuel.id, _naics.id, _organisation.id, _report.id, _unit.id,
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
        -- FK Emission -> Facility
        left join ggircs_swrs.facility as _facility
            on _emission.ghgr_import_id = _facility.ghgr_import_id
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
        -- FK Emission -> Fuel Mapping
        left join ggircs_swrs.fuel_mapping as _fuel_mapping
            on ((_fuel_mapping.fuel_type = 'Flared Natural Gas CO2'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas CH4'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas N20'
                and _activity.sub_process_name = 'Flaring'
                and _emission.gas_type like 'CO2%')
            or (_fuel_mapping.fuel_type = 'Flared Natural Gas CH4'
                and _activity.sub_process_name = 'Flaring'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas CO2'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas N20'
                and _emission.gas_type = 'CH4')
            or (_fuel_mapping.fuel_type = 'Flared Natural Gas N2O'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas CH4'
                and _fuel_mapping.fuel_type != 'Flared Natural Gas CO2'
                and _activity.sub_process_name = 'Flaring'
                and _emission.gas_type = 'N2O')
            or (_fuel_mapping.fuel_type = 'Vented Natural Gas'
                and _emission.emission_type
                    in (
                       'NG Distribution: NG continuous high bleed devices venting',
                       'NG Distribution: NG continuous low bleed devices venting',
                       'NG Distribution: NG intermittent devices venting',
                       'NG Distribution: NG pneumatic pumps venting',
                       'Onshore NG Transmission Compression/Pipelines: NG continuous high bleed devices venting',
                       'Onshore NG Transmission Compression/Pipelines: NG continuous low bleed devices venting',
                       'Onshore NG Transmission Compression/Pipelines: NG intermittent devices venting',
                       'Onshore NG Transmission Compression/Pipelines: NG pneumatic pumps venting',
                       'Onshore Petroleum and NG Production: NG continuous high bleed devices venting',
                       'Onshore Petroleum and NG Production: NG continuous low bleed devices venting',
                       'Onshore Petroleum and NG Production: NG intermittent devices venting',
                       'Onshore Petroleum and NG Production: NG pneumatic pump venting',
                       'Underground NG Storage: NG continuous high bleed devices venting',
                       'Underground NG Storage: NG continuous low bleed devices venting',
                       'Underground NG Storage: NG intermittent devices venting',
                       'Underground NG Storage: NG pneumatic pumps venting'
                       )))
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

    end
$function$ language plpgsql volatile;

commit;

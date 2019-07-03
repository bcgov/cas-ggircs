set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'pro_rated_fuel_charge',
    'ggircs.pro_rated_fuel_charge should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'pro_rated_fuel_charge'::name, array[
    'fuel_type'::name,
    'fuel_mapping_id'::name,
    'year'::name,
    'unit_conversion_factor'::name,
    'flat_rate'::name,
    'pro_rated_fuel_charge'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'pro_rated_fuel_charge', 'fuel_type', 'character varying(1000)', 'pro_rated_fuel_charge.fuel_type column should be type varchar');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'fuel_type', 'pro_rated_fuel_charge.fuel_type column should not have a default value');

select col_type_is('ggircs', 'pro_rated_fuel_charge', 'fuel_mapping_id', 'integer', 'pro_rated_fuel_charge.fuel_mapping_id column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'fuel_mapping_id', 'pro_rated_fuel_charge.fuel_mapping_id column should not have a default value');

select col_type_is('ggircs', 'pro_rated_fuel_charge', 'year', 'integer', 'pro_rated_fuel_charge.year column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'year', 'pro_rated_fuel_charge.year column should not have a default value');

select col_type_is('ggircs', 'pro_rated_fuel_charge', 'unit_conversion_factor', 'integer', 'pro_rated_fuel_charge.unit_conversion_factor column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'unit_conversion_factor', 'pro_rated_fuel_charge.unit_conversion_factor column should not have a default value');

select col_type_is('ggircs', 'pro_rated_fuel_charge', 'flat_rate', 'numeric', 'pro_rated_fuel_charge.flat_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'flat_rate', 'pro_rated_fuel_charge.flat_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_fuel_charge', 'pro_rated_fuel_charge', 'numeric', 'pro_rated_fuel_charge.pro_rated_fuel_charge column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_fuel_charge', 'pro_rated_fuel_charge', 'pro_rated_fuel_charge.pro_rated_fuel_charge column should not have a default value');


-- XML fixture for testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>322112</Code>
        <NaicsPriority>Primary</NaicsPriority>
      </NAICSCode>
    </NAICSCodeList>
  </RegistrationData>
  <ReportDetails>
    <ReportID>123500000</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2015</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Cogen Units">
            <Unit>
              <Fuels>
                <Fuel>
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions><Emission></Emission></Emissions>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- Refresh necessary materialized views
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.final_report with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.activity with data;
refresh materialized view ggircs_swrs.unit with data;
refresh materialized view ggircs_swrs.identifier with data;
refresh materialized view ggircs_swrs.naics with data;
refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.emission with data;

-- Populate necessary ggircs tables
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
      on _organisation.ghgr_import_id = _report.ghgr_import_id
    ;

    select ggircs_swrs.export_facility_to_ggircs();

    -- ACTIVITY
    delete from ggircs.activity;
    insert into ggircs.activity (id, ghgr_import_id, facility_id,  report_id, activity_name, process_name, sub_process_name, information_requirement)

    select _activity.id, _activity.ghgr_import_id, _facility.id, _report.id, _activity.activity_name, _activity.process_name, _activity.sub_process_name, _activity.information_requirement

    from ggircs_swrs.activity as _activity

    inner join ggircs_swrs.final_report as _final_report on _activity.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Activity ->  Facility
    left join ggircs_swrs.facility as _facility
      on _activity.ghgr_import_id = _facility.ghgr_import_id

    -- FK Activity -> Report
    left join ggircs_swrs.report as _report
      on _activity.ghgr_import_id = _report.ghgr_import_id
    ;

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
      and _unit.activity_name = _activity.activity_name
    ;

    -- IDENTIFIER
    delete from ggircs.identifier;
    insert into ggircs.identifier(id, ghgr_import_id, facility_bcghgid_id, facility_id,  report_id, swrs_facility_id, path_context, identifier_type, identifier_value)

    select _identifier.id, _identifier.ghgr_import_id, _facility_bcghgid.id, _facility.id,  _report.id, _identifier.swrs_facility_id, _identifier.path_context, _identifier.identifier_type, _identifier.identifier_value

    from ggircs_swrs.identifier as _identifier

    inner join ggircs_swrs.final_report as _final_report on _identifier.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Identifier -> Facility
    left join ggircs_swrs.facility as _facility
      on _identifier.ghgr_import_id = _facility.ghgr_import_id
    -- FK Identifier -> Report
    left join ggircs_swrs.report as _report
      on _identifier.ghgr_import_id = _report.ghgr_import_id
    left join ggircs.facility as _facility_bcghgid
      on _identifier.ghgr_import_id = _facility_bcghgid.ghgr_import_id
      and (((_identifier.path_context = 'RegistrationData'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' )

               and (select id from ggircs_swrs.identifier as __identifier
                  where __identifier.ghgr_import_id = _facility_bcghgid.ghgr_import_id
                  and __identifier.path_context = 'VerifyTombstone'
                  and __identifier.identifier_type = 'BCGHGID'
                  and __identifier.identifier_value is not null
                  and __identifier.identifier_value != '') is null)
          or (_identifier.path_context = 'VerifyTombstone'
             and _identifier.identifier_type = 'BCGHGID'
             and _identifier.identifier_value is not null
             and _identifier.identifier_value != '' ))
      ;

    -- NAICS
    delete from ggircs.naics;
    insert into ggircs.naics(id, ghgr_import_id, facility_id,  registration_data_facility_id, naics_category_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

    select _naics.id, _naics.ghgr_import_id, _facility.id,
        (select _facility.id where _naics.path_context = 'RegistrationData'),
        _naics_category.id, _report.id, _naics.swrs_facility_id,
        _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

    from ggircs_swrs.naics as _naics
    inner join ggircs_swrs.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Naics ->  Facility
    left join ggircs_swrs.facility as _facility
      on _naics.ghgr_import_id = _facility.ghgr_import_id
    -- FK Naics -> Report
    left join ggircs_swrs.report as _report
      on _naics.ghgr_import_id = _report.ghgr_import_id
    -- FK Naics -> Naics Mapping
    left join ggircs_swrs.naics_naics_category as _naics_category
      on (_naics.naics_code = _naics_category.naics_code
            or (_naics.naics_code not in (select naics_code from ggircs_swrs.naics_naics_category)
                and _naics.naics_code::text like _naics_category.naics_code_pattern)
         );

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
      on _fuel.fuel_type = _fuel_mapping.fuel_type
      ;

    -- EMISSION
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

-- Properly selects fuel charge
select results_eq(
    $$ select flat_rate / unit_conversion_factor from ggircs.pro_rated_fuel_charge where fuel_type = 'Residual Fuel Oil (#5 & 6)'$$,

    $$

      select fuel_charge from ggircs.fuel
      join ggircs_swrs.fuel_charge
      on fuel.fuel_mapping_id = fuel_charge.fuel_mapping_id
      where fuel.fuel_type = 'Residual Fuel Oil (#5 & 6)'
      and ('2013-12-31' between fuel_charge.start_date and fuel_charge.end_date)

    $$,

    'ggircs.pro_rated_fuel_charge selects proper fuel_charge for fuel_type and year'
);

select * from finish();
rollback;

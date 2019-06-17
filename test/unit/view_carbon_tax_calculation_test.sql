set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'carbon_tax_calculation',
    'ggircs.carbon_tax_calculation should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'carbon_tax_calculation'::name, array[
    'organisation_id'::name,
    'single_facility_id'::name,
    'lfo_facility_id'::name,
    'naics_id'::name,
    'naics_mapping_id'::name,
    'year'::name,
    'fuel_type'::name,
    'amount'::name,
    'calculated_carbon_tax'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'carbon_tax_calculation', 'organisation_id', 'integer', 'carbon_tax_calculation.organisation_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'organisation_id', 'carbon_tax_calculation.organisation_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'single_facility_id', 'integer', 'carbon_tax_calculation.single_facility_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'single_facility_id', 'carbon_tax_calculation.single_facility_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'lfo_facility_id', 'integer', 'carbon_tax_calculation.lfo_facility_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'lfo_facility_id', 'carbon_tax_calculation.lfo_facility_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'naics_id', 'integer', 'carbon_tax_calculation.naics_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'naics_id', 'carbon_tax_calculation.naics_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'naics_mapping_id', 'integer', 'carbon_tax_calculation.naics_mapping_id column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'naics_mapping_id', 'carbon_tax_calculation.naics_mapping_id column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'year', 'integer', 'carbon_tax_calculation.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'year', 'carbon_tax_calculation.reporting_year column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'fuel_type', 'character varying(1000)', 'carbon_tax_calculation.fuel_type column should be type varchar');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'fuel_type', 'carbon_tax_calculation.fuel_type column should not have a default value');

select col_type_is('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'numeric', 'carbon_tax_calculation.calculated_carbon_tax column should be type numeric');
select col_hasnt_default('ggircs', 'carbon_tax_calculation', 'calculated_carbon_tax', 'carbon_tax_calculation.calculated_carbon_tax column should not have a default value');

-- XML fixture for testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
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
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$), ($$
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
    <ReportID>1235</ReportID>
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
refresh materialized view ggircs_swrs.naics with data;
refresh materialized view ggircs_swrs.fuel with data;

-- Populate necessary ggircs tables

-- REPORT
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

    select id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

    from ggircs_swrs.report;

-- ORGANISATION
    insert into ggircs.organisation (id, ghgr_import_id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

    select _organisation.id, _organisation.ghgr_import_id, _report.id, _organisation.swrs_organisation_id, _organisation.business_legal_name,
           _organisation.english_trade_name, _organisation.french_trade_name, _organisation.cra_business_number, _organisation.duns, _organisation.website

    from ggircs_swrs.organisation as _organisation

    inner join ggircs_swrs.final_report as _final_report on _organisation.ghgr_import_id = _final_report.ghgr_import_id
    --FK Organisation -> Report
    left join ggircs_swrs.report as _report
      on _organisation.ghgr_import_id = _report.ghgr_import_id;

    -- SINGLE FACILITY
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
    insert into ggircs.single_facility (id, ghgr_import_id, identifier_id, organisation_id, report_id, swrs_facility_id, parent_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, null, _organisation.id, _report.id, _facility.swrs_facility_id, _final_lfo_facility.id, _facility.facility_name, _facility.facility_type,
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

    -- LFO FACILITY
    insert into ggircs.lfo_facility (id, ghgr_import_id, identifier_id, organisation_id, report_id, swrs_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, null, _organisation.id, _report.id, _facility.swrs_facility_id, _facility.facility_name, _facility.facility_type,
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

-- NAICS
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
    insert into ggircs.fuel(id, ghgr_import_id, report_id,
                            activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                            fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                            other_flare_details, q1, q2, q3, q4, wastewater_processing_factors, measured_conversion_factors)

    select _fuel.id, _fuel.ghgr_import_id, _report.id,
           _fuel.activity_name, _fuel.sub_activity_name, _fuel.unit_name, _fuel.sub_unit_name, _fuel.fuel_type, _fuel.fuel_classification, _fuel.fuel_description,
           _fuel.fuel_units, _fuel.annual_fuel_amount, _fuel.annual_weighted_avg_carbon_content, _fuel.annual_weighted_avg_hhv, _fuel.annual_steam_generation,
           _fuel.alternative_methodology_description, _fuel.other_flare_details, _fuel.q1, _fuel.q2, _fuel.q3, _fuel.q4, _fuel.wastewater_processing_factors, _fuel.measured_conversion_factors

    from ggircs_swrs.fuel
    left join ggircs_swrs.fuel as _fuel on _fuel.id = fuel.id
    -- FK Fuel -> Report
    left join ggircs_swrs.report as _report
    on _fuel.ghgr_import_id = _report.ghgr_import_id;

-- Test fk relations
-- Organisation
select set_eq(
    $$ select organisation.swrs_organisation_id from ggircs.carbon_tax_calculation as ct
       join ggircs.organisation on ct.organisation_id = organisation.id
    $$,
    'select swrs_organisation_id from ggircs.organisation',
    'fk organisation_id references organisation'
);

-- Single Facility
select set_eq(
    $$ select single_facility.swrs_facility_id from ggircs.carbon_tax_calculation as ct
       join ggircs.single_facility on ct.single_facility_id = single_facility.id
    $$,
    'select swrs_facility_id from ggircs.single_facility',
    'fk single_facility_id references single_facility'
);

-- Naics
select set_eq(
    $$ select naics.naics_code from ggircs.carbon_tax_calculation as ct
       join ggircs.naics on ct.naics_id = naics.id
    $$,
    'select naics_code from ggircs.naics',
    'fk naics_id references naics'
);

-- Naics
select set_eq(
    $$ select naics_mapping.hhw_category from ggircs.carbon_tax_calculation as ct
       join ggircs_swrs.naics_mapping on ct.naics_mapping_id = naics_mapping.id
    $$,
    'select hhw_category from ggircs_swrs.naics_mapping where naics_code = 322112',
    'fk naics_mapping_id references naics_mapping'
);

-- Test validity of calculation
select results_eq(
    'select calculated_carbon_tax from ggircs.carbon_tax_calculation order by calculated_carbon_tax',

    $$
    with x as (
        select fuel.fuel_type                           as fuel_type,
               fuel.annual_fuel_amount                  as amount,
               report.reporting_period_duration::integer         as rpd,
               pro_rated_carbon_tax_rate                as pro_rated_ctr,
               pro_rated_implied_emission_factor        as pro_rated_ief
        from ggircs.fuel
                join ggircs_swrs.fuel_mapping as fm
                    on fuel.fuel_type = fm.fuel_type
                join ggircs.report as report
                    on fuel.report_id = report.id
                join ggircs.pro_rated_carbon_tax_rate as ctr
                    on fuel.fuel_type = ctr.fuel_type
                    and report.reporting_period_duration::integer = ctr.reporting_year
                join ggircs.pro_rated_implied_emission_factor as ief
                    on ief.fuel_mapping_id = fm.id
                    and report.reporting_period_duration::integer = ief.reporting_year

    )
    select
      (x.amount * x.pro_rated_ctr * x.pro_rated_ief) as calculated_carbon_tax
    from x order by calculated_carbon_tax
    $$,

    'ggircs.carbon_tax_calculation properly calculates carbon tax based on fuel_amount * pro-rated carbon tax rate * pro-rated implied emission factor'
);

select * from finish();
rollback;

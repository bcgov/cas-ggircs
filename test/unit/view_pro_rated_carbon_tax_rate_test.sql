set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(25);

-- View should exist
select has_view(
    'ggircs', 'pro_rated_carbon_tax_rate',
    'ggircs.pro_rated_carbon_tax_rate should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'pro_rated_carbon_tax_rate'::name, array[
    'reporting_year'::name,
    'fuel_type'::name,
    'year_length'::name,
    'start_rate'::name,
    'start_duration'::name,
    'end_rate'::name,
    'end_duration'::name,
    'pro_rated_carbon_tax_rate'::name
]);

-- Column attributes are correct
select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'integer', 'pro_rated_carbon_tax_rate.reporting_year column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'pro_rated_carbon_tax_rate.reporting_year column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'character varying(1000)', 'pro_rated_carbon_tax_rate.fuel_type column should be type character varying(1000)');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'pro_rated_carbon_tax_rate.fuel_type column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'year_length', 'integer', 'pro_rated_carbon_tax_rate.year_length column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'year_length', 'pro_rated_carbon_tax_rate.year_length column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'start_rate', 'numeric', 'pro_rated_carbon_tax_rate.start_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'start_rate', 'pro_rated_carbon_tax_rate.start_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'start_duration', 'integer', 'pro_rated_carbon_tax_rate.start_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'start_duration', 'pro_rated_carbon_tax_rate.start_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'end_rate', 'numeric', 'pro_rated_carbon_tax_rate.end_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'end_rate', 'pro_rated_carbon_tax_rate.end_rate column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'end_duration', 'integer', 'pro_rated_carbon_tax_rate.end_duration column should be type integer');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'end_duration', 'pro_rated_carbon_tax_rate.end_duration column should not have a default value');

select col_type_is('ggircs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'numeric', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should be type numeric');
select col_hasnt_default('ggircs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should not have a default value');

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
  <ReportDetails>
    <ReportID>1235</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
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
refresh materialized view ggircs_swrs.fuel with data;

-- Populate necessary ggircs tables
-- REPORT
    insert into ggircs.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id)

    select id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, swrs_report_history_id

    from ggircs_swrs.report;

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

-- Test Pro-rated results
select results_eq(
    'select reporting_year from ggircs.pro_rated_carbon_tax_rate order by reporting_year',

    $$
    select reporting_period_duration::integer
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
    on report.ghgr_import_id = fuel.ghgr_import_id
    order by reporting_period_duration
    $$,

    'pro_rated_carbon_tax_rate properly selects the reporting year'
);

select results_eq(
    $$ select year_length from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by year_length$$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
    on report.ghgr_import_id = fuel.ghgr_import_id
    )
    select concat((x.rpd::integer)::text, '-12-31')::date - concat((x.rpd::integer)::text, '-01-01')::date as year_length
    from x where x.fuel_type = 'Wood Waste'
    order by year_length
    $$,

    'pro_rated_carbon_tax_rate properly selects the length of the reporting year in days'
);

select results_eq(
    $$ select start_rate from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by start_rate desc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.carbon_tax_rate as rate
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
        on report.ghgr_import_id = fuel.ghgr_import_id
    join ggircs_swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )
    select
           case
               when x.rpd::integer <= 2017 then 0
               when x.rpd::integer > 2021 then (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = (select max(id) from ggircs_swrs.carbon_tax_rate_mapping))
               else x.rate
           end as start_rate
    from x where x.fuel_type = 'Wood Waste' order by start_rate desc
    $$,

    'pro_rated_carbon_tax_rate properly selects the carbon tax rate for prior to the rate hike date'
);

select results_eq(
    $$ select start_duration from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by start_duration asc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.id as id
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
        on report.ghgr_import_id = fuel.ghgr_import_id
    join ggircs_swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )

    select
        case
            when x.rpd::integer <= 2017 then 0
            when x.rpd::integer > 2021 then concat((x.rpd::integer)::text, '-04-01')::date - concat((x.rpd::integer)::text, '-01-01')::date
            else (select rate_start_date
                  from ggircs_swrs.carbon_tax_rate_mapping
                  where id = x.id+1) - concat((x.rpd::integer)::text, '-01-01')::date
        end as start_duration
    from x where x.fuel_type = 'Wood Waste' order by start_duration asc
    $$,

    'pro_rated_carbon_tax_rate properly selects the duration in days of the starting rate prior to the rate hike date'
);

select results_eq(
    $$ select end_rate from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by end_rate desc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.carbon_tax_rate as rate, ctr.id as id
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
        on report.ghgr_import_id = fuel.ghgr_import_id
    join ggircs_swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )
    select
           case
               when x.rpd::integer < 2017 then 0
               when x.rpd::integer = 2017 then 30
               when x.rpd::integer > 2021 then (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = (select max(id) from ggircs_swrs.carbon_tax_rate_mapping))
               else (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = x.id+1)
           end as end_rate
    from x where x.fuel_type = 'Wood Waste' order by end_rate desc
    $$,

    'pro_rated_carbon_tax_rate properly selects the carbon tax rate for prior to the rate hike date'
);

select results_eq(
    $$ select end_duration from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.id as id
    from ggircs_swrs.fuel as fuel
    join ggircs_swrs.report as report
        on report.ghgr_import_id = fuel.ghgr_import_id
    join ggircs_swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )

    select case
               when x.rpd::integer < 2017 then 0
               when x.rpd::integer = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd::integer > 2021 then concat((x.rpd::integer)::text, '-12-31')::date - concat((x.rpd::integer)::text, '-04-01')::date
               else concat((x.rpd::integer)::text, '-12-31')::date - (select rate_start_date
                                                             from ggircs_swrs.carbon_tax_rate_mapping
                                                             where id = x.id+1)
           end as end_duration
    from x where x.fuel_type = 'Wood Waste' order by end_duration asc
    $$,

    'pro_rated_carbon_tax_rate properly selects the duration in days of the ending rate after to the rate hike date'
);

select results_eq(
    $$ select pro_rated_carbon_tax_rate from ggircs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by pro_rated_carbon_tax_rate asc $$,

    $$
    with x as (
        select fuel.fuel_type                   as fuel_type,
               report.reporting_period_duration as rpd,
               ctr.rate_start_date              as start,
               ctr.rate_end_date                as end,
               ctr.carbon_tax_rate              as rate,
               ctr.id                           as id
        from ggircs_swrs.fuel
                 join ggircs_swrs.report as report
                      on fuel.ghgr_import_id = report.ghgr_import_id
                 join ggircs_swrs.carbon_tax_rate_mapping as ctr
                      on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
                      and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    ), y as (
    select x.rpd::integer as reporting_year,
           x.fuel_type as fuel_type,
           case
               when x.rpd::integer <= 2017 then 0
               when x.rpd::integer > 2021 then (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = (select max(id) from ggircs_swrs.carbon_tax_rate_mapping))
               else x.rate
           end as start_rate,

           case
               when x.rpd::integer < 2017 then 0
               when x.rpd::integer = 2017 then 30
               when x.rpd::integer > 2021 then (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = (select max(id) from ggircs_swrs.carbon_tax_rate_mapping))
               else (select carbon_tax_rate from ggircs_swrs.carbon_tax_rate_mapping where id = x.id+1)
           end as end_rate,

           case
               when x.rpd::integer <= 2017 then 0
               when x.rpd::integer > 2021 then concat((x.rpd::integer)::text, '-04-01')::date - concat((x.rpd::integer)::text, '-01-01')::date
               else (select rate_start_date
                     from ggircs_swrs.carbon_tax_rate_mapping
                     where id = x.id+1) - concat((x.rpd::integer)::text, '-01-01')::date
           end as start_duration,

           case
               when x.rpd::integer < 2017 then 0
               when x.rpd::integer = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd::integer > 2021 then concat((x.rpd::integer)::text, '-12-31')::date - concat((x.rpd::integer)::text, '-04-01')::date
               else concat((x.rpd::integer)::text, '-12-31')::date - (select rate_start_date
                                                             from ggircs_swrs.carbon_tax_rate_mapping
                                                             where id = x.id+1)
           end as end_duration,

           concat((x.rpd::integer)::text, '-12-31')::date - concat((x.rpd::integer)::text, '-01-01')::date as year_length
    from x)
    select
           ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_carbon_tax_rate
    from y where y.fuel_type = 'Wood Waste' order by pro_rated_carbon_tax_rate asc
    $$,

    'pro_rated_carbon_tax_rate properly calculates the pro_rated_carbon_tax_rate'
);

select * from ggircs.pro_rated_carbon_tax_rate;

select * from finish();
rollback;

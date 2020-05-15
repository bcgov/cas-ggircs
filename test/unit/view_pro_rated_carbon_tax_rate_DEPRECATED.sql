set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(25);

-- View should exist
select has_view(
    'swrs', 'pro_rated_carbon_tax_rate',
    'swrs.pro_rated_carbon_tax_rate should be a view'
);

-- Columns are correct
select columns_are('swrs'::name, 'pro_rated_carbon_tax_rate'::name, array[
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
select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'integer', 'pro_rated_carbon_tax_rate.reporting_year column should be type integer');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'reporting_year', 'pro_rated_carbon_tax_rate.reporting_year column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'character varying(1000)', 'pro_rated_carbon_tax_rate.fuel_type column should be type character varying(1000)');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'fuel_type', 'pro_rated_carbon_tax_rate.fuel_type column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'year_length', 'integer', 'pro_rated_carbon_tax_rate.year_length column should be type integer');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'year_length', 'pro_rated_carbon_tax_rate.year_length column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'start_rate', 'numeric', 'pro_rated_carbon_tax_rate.start_rate column should be type numeric');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'start_rate', 'pro_rated_carbon_tax_rate.start_rate column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'start_duration', 'integer', 'pro_rated_carbon_tax_rate.start_duration column should be type integer');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'start_duration', 'pro_rated_carbon_tax_rate.start_duration column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'end_rate', 'numeric', 'pro_rated_carbon_tax_rate.end_rate column should be type numeric');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'end_rate', 'pro_rated_carbon_tax_rate.end_rate column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'end_duration', 'integer', 'pro_rated_carbon_tax_rate.end_duration column should be type integer');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'end_duration', 'pro_rated_carbon_tax_rate.end_duration column should not have a default value');

select col_type_is('swrs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'numeric', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should be type numeric');
select col_hasnt_default('swrs', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate', 'pro_rated_carbon_tax_rate.pro_rated_carbon_tax_rate column should not have a default value');

-- XML fixture for testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Test Pro-rated results
select results_eq(
    'select reporting_year from swrs.pro_rated_carbon_tax_rate order by reporting_year',

    $$
    select reporting_period_duration
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
    on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    order by reporting_period_duration
    $$,

    'pro_rated_carbon_tax_rate properly selects the reporting year'
);

select results_eq(
    $$ select year_length from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by year_length$$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
    on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    )
    select concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length
    from x where x.fuel_type = 'Wood Waste'
    order by year_length
    $$,

    'pro_rated_carbon_tax_rate properly selects the length of the reporting year in days'
);

select results_eq(
    $$ select start_rate from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by start_rate desc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.carbon_tax_rate as rate
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
        on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    join swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )
    select
           case
               when x.rpd <= 2017 then 0
               when x.rpd > 2021 then (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = (select max(id) from swrs.carbon_tax_rate_mapping))
               else x.rate
           end as start_rate
    from x where x.fuel_type = 'Wood Waste' order by start_rate desc
    $$,

    'pro_rated_carbon_tax_rate properly selects the carbon tax rate for prior to the rate hike date'
);

select results_eq(
    $$ select start_duration from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by start_duration asc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.id as id
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
        on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    join swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )

    select
        case
            when x.rpd <= 2017 then 0
            when x.rpd > 2021 then concat(x.rpd)::text, '-04-01')::date - concat((x.rpd)::text, '-01-01')::date
            else (select rate_start_date
                  from swrs.carbon_tax_rate_mapping
                  where id = x.id+1) - concat((x.rpd)::text, '-01-01')::date
        end as start_duration
    from x where x.fuel_type = 'Wood Waste' order by start_duration asc
    $$,

    'pro_rated_carbon_tax_rate properly selects the duration in days of the starting rate prior to the rate hike date'
);

select results_eq(
    $$ select end_rate from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by end_rate desc $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.carbon_tax_rate as rate, ctr.id as id
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
        on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    join swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )
    select
           case
               when x.rpd < 2017 then 0
               when x.rpd = 2017 then 30
               when x.rpd > 2021 then (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = (select max(id) from swrs.carbon_tax_rate_mapping))
               else (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = x.id+1)
           end as end_rate
    from x where x.fuel_type = 'Wood Waste' order by end_rate desc
    $$,

    'pro_rated_carbon_tax_rate properly selects the carbon tax rate for prior to the rate hike date'
);

select results_eq(
    $$ select end_duration from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' $$,

    $$
    with x as (
    select reporting_period_duration as rpd, fuel_type, ctr.id as id
    from swrs_transform.fuel as fuel
    join swrs_transform.report as report
        on report.eccc_xml_file_id = fuel.eccc_xml_file_id
    join swrs.carbon_tax_rate_mapping as ctr
        on concat((report.reporting_period_duration - 1)::text, '-04-01')::date >= ctr.rate_start_date
        and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    )

    select case
               when x.rpd < 2017 then 0
               when x.rpd = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd > 2021 then concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-04-01')::date
               else concat((x.rpd)::text, '-12-31')::date - (select rate_start_date
                                                             from swrs.carbon_tax_rate_mapping
                                                             where id = x.id+1)
           end as end_duration
    from x where x.fuel_type = 'Wood Waste' order by end_duration asc
    $$,

    'pro_rated_carbon_tax_rate properly selects the duration in days of the ending rate after to the rate hike date'
);

select results_eq(
    $$ select pro_rated_carbon_tax_rate from swrs.pro_rated_carbon_tax_rate where fuel_type = 'Wood Waste' order by pro_rated_carbon_tax_rate asc $$,

    $$
    with x as (
        select fuel.fuel_type                   as fuel_type,
               report.reporting_period_duration as rpd,
               ctr.rate_start_date              as start,
               ctr.rate_end_date                as end,
               ctr.carbon_tax_rate              as rate,
               ctr.id                           as id
        from swrs_transform.fuel
                 join swrs_transform.report as report
                      on fuel.eccc_xml_file_id = report.eccc_xml_file_id
                 join swrs.carbon_tax_rate_mapping as ctr
                      on concat((report.reporting_period_duration - 1)::text, '-04-01')::date >= ctr.rate_start_date
                      and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    ), y as (
    select x.rpd as reporting_year,
           x.fuel_type as fuel_type,
           case
               when x.rpd <= 2017 then 0
               when x.rpd > 2021 then (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = (select max(id) from swrs.carbon_tax_rate_mapping))
               else x.rate
           end as start_rate,

           case
               when x.rpd < 2017 then 0
               when x.rpd = 2017 then 30
               when x.rpd > 2021 then (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = (select max(id) from swrs.carbon_tax_rate_mapping))
               else (select carbon_tax_rate from swrs.carbon_tax_rate_mapping where id = x.id+1)
           end as end_rate,

           case
               when x.rpd <= 2017 then 0
               when x.rpd > 2021 then concat((x.rpd)::text, '-04-01')::date - concat((x.rpd)::text, '-01-01')::date
               else (select rate_start_date
                     from swrs.carbon_tax_rate_mapping
                     where id = x.id+1) - concat((x.rpd)::text, '-01-01')::date
           end as start_duration,

           case
               when x.rpd < 2017 then 0
               when x.rpd = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd > 2021 then concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-04-01')::date
               else concat((x.rpd)::text, '-12-31')::date - (select rate_start_date
                                                             from swrs.carbon_tax_rate_mapping
                                                             where id = x.id+1)
           end as end_duration,

           concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length
    from x)
    select
           ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_carbon_tax_rate
    from y where y.fuel_type = 'Wood Waste' order by pro_rated_carbon_tax_rate asc
    $$,

    'pro_rated_carbon_tax_rate properly calculates the pro_rated_carbon_tax_rate'
);

select * from finish();
rollback;

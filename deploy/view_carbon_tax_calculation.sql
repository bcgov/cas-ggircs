-- Deploy ggircs:view_carbon_tax_calculation to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

begin;

create or replace view ggircs.carbon_tax_calculation as
    with x as (
        select fuel.fuel_type                           as fuel_type,
               fuel.annual_fuel_amount                  as amount,
               report.reporting_period_duration::integer         as rpd
        from ggircs.fuel
                join ggircs_swrs.fuel_mapping as fm
                    on fuel.fuel_type = fm.fuel_type
                join ggircs.report as report
                    on fuel.report_id = report.id
    ),
    y as (
    select x.rpd as year,
           x.fuel_type as fuel_type,
           x.amount as amount,
          (select distinct(pro_rated_carbon_tax_rate) from ggircs.pro_rated_carbon_tax_rate
                    where fuel_type = x.fuel_type
                    and reporting_year = x.rpd) as pro_rated_ctr,
          (select distinct(pro_rated_implied_emission_factor) from ggircs.pro_rated_implied_emission_factor
                    where fuel_type = x.fuel_type
                    and reporting_year = x.rpd) as pro_rated_ief
    from x)
    select
           y.year,
           y.fuel_type,
           (y.amount * y.pro_rated_ctr * y.pro_rated_ief) as calculated_carbon_tax

    from y
;
commit;

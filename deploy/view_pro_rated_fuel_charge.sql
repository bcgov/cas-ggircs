-- Deploy ggircs:view_pro_rated_fuel_charge to pg
-- requires: table_report
-- requires: table_fuel
-- requires: table_fuel_mapping
-- requires: table_fuel_charge

begin;

create or replace view ggircs.pro_rated_fuel_charge as
    with x as (
        select fuel.ghgr_import_id,
               _fuel_mapping.fuel_type,
               coalesce(fuel.fuel_mapping_id, _emission.fuel_mapping_id)        as fuel_mapping_id,
               _report.reporting_period_duration::integer                       as rpd,
               _fuel_charge.start_date,
               _fuel_charge.end_date,
               _fuel_charge.fuel_charge,
               _fuel_charge.id                                                  as fuel_charge_id,
               _fuel_carbon_tax_details.unit_conversion_factor,
               concat(_report.reporting_period_duration::text, '-12-31')::date - concat(_report.reporting_period_duration::text, '-01-01')::date as year_length,
               case when
                    _report.reporting_period_duration::integer <= 2017
                    then 365
                    when
                    start_date < concat(_report.reporting_period_duration::text, '-01-01')::date and end_date < concat(_report.reporting_period_duration::text, '-12-31')::date
                    then end_date - concat(_report.reporting_period_duration::text, '-01-01')::date
                    when
                    start_date > concat(_report.reporting_period_duration::text, '-01-01')::date and end_date < concat(_report.reporting_period_duration::text, '-12-31')::date
                    then
                    end_date - start_date
                    when
                    start_date > concat(_report.reporting_period_duration::text, '-01-01')::date and end_date > concat(_report.reporting_period_duration::text, '-12-31')::date
                    then
                    concat(_report.reporting_period_duration::text, '-12-31')::date - start_date
                   -- Todo: case when reporting year -01-01 > end date of last rate band
                end as duration
        from ggircs.fuel
                 join ggircs.report as _report
                      on fuel.report_id = _report.id
                 left join ggircs.emission as _emission
                      on fuel.id = _emission.fuel_id
                 join ggircs_swrs.fuel_mapping as _fuel_mapping
                      on fuel.fuel_mapping_id = _fuel_mapping.id
                      or _emission.fuel_mapping_id = _fuel_mapping.id
                 join ggircs_swrs.fuel_carbon_tax_details as _fuel_carbon_tax_details
                      on _fuel_mapping.fuel_carbon_tax_details_id = _fuel_carbon_tax_details.id
                      or _emission.fuel_mapping_id = _fuel_carbon_tax_details.id
                 join ggircs_swrs.fuel_charge as _fuel_charge
                      on _fuel_charge.fuel_mapping_id = _fuel_mapping.id

    ), y as (select rpd, fuel_mapping_id, fuel_type, year_length, duration, fuel_charge, unit_conversion_factor,
            (select _fuel_charge.fuel_charge * x.unit_conversion_factor
                      from ggircs_swrs.fuel_charge as _fuel_charge
                      where concat(x.rpd::text, '-12-31')::date between _fuel_charge.start_date and _fuel_charge.end_date
                      and _fuel_charge.fuel_mapping_id = x.fuel_mapping_id
                   ) as flat_rate,
             case when rpd <= 2017
                 then
                    (select distinct(fuel_charge) * unit_conversion_factor
                       from ggircs_swrs.fuel_charge
                       where id = (
                           select min(_fuel_charge.id)
                           from ggircs_swrs.fuel_charge as _fuel_charge
                           where _fuel_charge.fuel_mapping_id = x.fuel_mapping_id)
                       )
             when rpd >2021
                 then
                    (select distinct(fuel_charge) * unit_conversion_factor
                       from ggircs_swrs.fuel_charge
                       where id = (
                           select max(_fuel_charge.id)
                           from ggircs_swrs.fuel_charge as _fuel_charge
                           where _fuel_charge.fuel_mapping_id = x.fuel_mapping_id)
                       )
                 else
                    ((select (duration::numeric / year_length::numeric) * fuel_charge * unit_conversion_factor))
            end as pro_rated_rates
            from x where duration > 0 group by fuel_mapping_id, rpd,fuel_type, year_length, fuel_charge, duration, unit_conversion_factor)
            select fuel_mapping_id,
                   fuel_type,
                   rpd,
                   sum(distinct(pro_rated_rates)) as pro_rated_fuel_charge,
                   flat_rate
            from y group by fuel_mapping_id, fuel_type, flat_rate, rpd;
commit;

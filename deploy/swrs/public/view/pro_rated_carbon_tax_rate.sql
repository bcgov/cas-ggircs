-- Deploy ggircs:view_pro_rated_carbon_rate to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

/** DEPRECATED **/

begin;

create or replace view ggircs.pro_rated_carbon_tax_rate as
    with x as (
        select fuel.fuel_type                   as fuel_type,
               report.reporting_period_duration::integer as rpd,
               ctr.rate_start_date              as start,
               ctr.rate_end_date                as end,
               ctr.carbon_tax_rate              as rate,
               ctr.id                           as id
        from ggircs.fuel
                 join ggircs.report as report
                      on fuel.ghgr_import_id = report.ghgr_import_id
                 join ggircs.carbon_tax_rate_mapping as ctr
                      on concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ctr.rate_start_date
                      and concat(report.reporting_period_duration::text, '-03-31')::date <= ctr.rate_end_date
    ), y as (
    select x.rpd::integer as reporting_year,
           x.fuel_type as fuel_type,
           case
               when x.rpd > 2021 then (select carbon_tax_rate from ggircs.carbon_tax_rate_mapping where id = (select max(id) from ggircs.carbon_tax_rate_mapping))
               else x.rate
           end as start_rate,

           case
               when x.rpd > 2021 then (select carbon_tax_rate from ggircs.carbon_tax_rate_mapping where id = (select max(id) from ggircs.carbon_tax_rate_mapping))
               else (select carbon_tax_rate from ggircs.carbon_tax_rate_mapping where id = x.id+1)
           end as end_rate,

           case
               when x.rpd > 2021 then concat((x.rpd)::text, '-04-01')::date - concat((x.rpd)::text, '-01-01')::date
               else (select rate_start_date
                     from ggircs.carbon_tax_rate_mapping
                     where id = x.id+1) - concat((x.rpd)::text, '-01-01')::date
           end as start_duration,

           case
               when x.rpd > 2021 then concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-04-01')::date
               else concat((x.rpd)::text, '-12-31')::date - (select rate_start_date
                                                             from ggircs.carbon_tax_rate_mapping
                                                             where id = x.id+1)
           end as end_duration,

           concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length
    from x)
    select
           y.reporting_year,
           y.fuel_type,
           y.year_length,
           y.start_rate,
           y.start_duration,
           y.end_rate,
           y.end_duration,
           ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_carbon_tax_rate
    from y group by reporting_year, fuel_type, year_length, start_rate, start_duration, end_rate, end_duration
;
commit;

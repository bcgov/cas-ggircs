-- Deploy ggircs:view_pro_rated_implied_emission_factor to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

/** DEPRECATED **/

begin;

create or replace view ggircs_swrs_load.pro_rated_implied_emission_factor as
    with x as (
        select fuel.fuel_type                   as fuel_type,
               report.reporting_period_duration::integer as rpd,
               fmap.id                           as fmap_id,
               ief.start_date                   as start,
               ief.end_date                     as end,
               ief.implied_emission_factor      as implied_emission_factor,
               ief.id                           as id,
               ief.fuel_mapping_id              as fuel_mapping_id
        from ggircs_swrs_load.fuel
                 join ggircs_swrs_load.report as report
                      on fuel.report_id = report.id
                 join ggircs_swrs_load.fuel_mapping as fmap
                      on fuel.fuel_type = fmap.fuel_type
                 join ggircs_swrs_load.implied_emission_factor as ief
                      on ief.fuel_mapping_id = fmap.id
                      and concat((report.reporting_period_duration::integer - 1)::text, '-04-01')::date >= ief.start_date
                      and concat(report.reporting_period_duration::text, '-03-31')::date <= ief.end_date

    ), y as (
    select x.id as id,
           x.rpd as reporting_year,
           x.fuel_type as fuel_type,
           x.fuel_mapping_id,
           case
               when x.rpd > 2021
               then (select implied_emission_factor
                       from ggircs_swrs_load.implied_emission_factor
                       where id = (
                           select max(ief.id)
                           from ggircs_swrs_load.implied_emission_factor as ief
                           join ggircs_swrs_load.fuel_mapping as fm
                           on ief.fuel_mapping_id = fm.id
                           and fm.fuel_type = x.fuel_type)
                       )
               else x.implied_emission_factor
           end as start_rate,

           case
               when x.rpd > 2021
                 then (select implied_emission_factor
                       from ggircs_swrs_load.implied_emission_factor
                       where id = (
                           select max(ief.id)
                           from ggircs_swrs_load.implied_emission_factor as ief
                           join ggircs_swrs_load.fuel_mapping as fm
                           on ief.fuel_mapping_id = fm.id
                           and fm.fuel_type = x.fuel_type)
                       )
               else (select implied_emission_factor from ggircs_swrs_load.implied_emission_factor where id = x.id+1)
           end as end_rate,

           case
               when x.rpd > 2021 then concat((x.rpd)::text, '-04-01')::date - concat((x.rpd)::text, '-01-01')::date
               else (select start_date
                     from ggircs_swrs_load.implied_emission_factor
                     where id = x.id+1) - concat((x.rpd)::text, '-01-01')::date
           end as start_duration,

           case
               when x.rpd = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd > 2021 then concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-04-01')::date
               else concat((x.rpd)::text, '-12-31')::date - (select start_date
                                                             from ggircs_swrs_load.implied_emission_factor
                                                             where id = x.id+1)
           end as end_duration,

           concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length
    from x)
    select
           y.reporting_year,
           y.fuel_type,
           y.fuel_mapping_id,
           y.year_length,
           y.start_rate,
           y.start_duration,
           y.end_rate,
           y.end_duration,
           ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_implied_emission_factor
    from y group by reporting_year, fuel_type, fuel_mapping_id, year_length, start_rate, start_duration, end_rate, end_duration
;
commit;

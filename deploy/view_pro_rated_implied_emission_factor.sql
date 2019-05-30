-- Deploy ggircs:view_pro_rated_implied_emission_factor to pg
-- requires: schema_ggircs

refresh materialized view ggircs_swrs.report;
refresh materialized view ggircs_swrs.fuel;

begin;

create or replace view ggircs.pro_rated_implied_emission_factor as
    with x as (
        select fuel.fuel_type                   as fuel_type,
               report.reporting_period_duration as rpd,
               fmap.id                           as fmap_id,
               ief.start_date                   as start,
               ief.end_date                     as end,
               ief.implied_emission_factor      as implied_emission_factor,
               ief.id                           as id
        from ggircs_swrs.fuel
                 join ggircs_swrs.report as report
                      on fuel.ghgr_import_id = report.ghgr_import_id
                 join ggircs_swrs.fuel_mapping as fmap
                      on fuel.fuel_type = fmap.fuel_type
                 join ggircs_swrs.implied_emission_factor as ief
                      on fuel_mapping_id = fmap.id
    ), y as (
    select x.rpd as reporting_year,
           x.fuel_type as fuel_type,
           case
               when x.rpd <= 2017 then 0
               when x.rpd > 2021 then (select implied_emission_factor from ggircs_swrs.implied_emission_factor where id = (select max(id) from ggircs_swrs.implied_emission_factor))
               else x.implied_emission_factor
           end as start_rate,

           case
               when x.rpd < 2017 then 0
               when x.rpd > 2021 then (select implied_emission_factor from ggircs_swrs.implied_emission_factor where id = (select max(id) from ggircs_swrs.implied_emission_factor))
               else (select implied_emission_factor from ggircs_swrs.implied_emission_factor where id = x.id+1)
           end as end_rate,

           case
               when x.rpd <= 2017 then 0
               when x.rpd > 2021 then concat((x.rpd)::text, '-04-01')::date - concat((x.rpd)::text, '-01-01')::date
               else (select start_date
                     from ggircs_swrs.implied_emission_factor
                     where id = x.id+1) - concat((x.rpd)::text, '-01-01')::date
           end as start_duration,

           case
               when x.rpd < 2017 then 0
               when x.rpd = 2017 then '2017-12-31'::date - '2017-04-01'::date
               when x.rpd > 2021 then concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-04-01')::date
               else concat((x.rpd)::text, '-12-31')::date - (select start_date
                                                             from ggircs_swrs.implied_emission_factor
                                                             where id = x.id+1)
           end as end_duration,

           concat((x.rpd)::text, '-12-31')::date - concat((x.rpd)::text, '-01-01')::date as year_length,
           row_number() over (partition by fuel_type, rpd order by rpd desc) as rn
    from x)
    select
           y.reporting_year,
           y.fuel_type,
           y.year_length,
           y.start_rate,
           y.start_duration,
           y.end_rate,
           y.end_duration,
           ((y.start_rate * y.start_duration) + (y.end_rate * y.end_duration)) / y.year_length as pro_rated_implied_emission_factor
    from y where y.rn = 1
;
commit;

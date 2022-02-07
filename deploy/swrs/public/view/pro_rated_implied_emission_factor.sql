-- Deploy ggircs:view_pro_rated_implied_emission_factor to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

/** DEPRECATED **/

begin;

drop view swrs.pro_rated_implied_emission_factor;

commit;

-- Deploy ggircs:view_pro_rated_carbon_rate to pg
-- requires:
    -- schema_ggircs
    -- table_fuel
    -- table_report

/** DEPRECATED **/

begin;

drop view swrs.pro_rated_carbon_tax_rate;

commit;

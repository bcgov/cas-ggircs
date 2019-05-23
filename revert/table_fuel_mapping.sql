-- Revert ggircs:table_fuel_mapping from pg

begin;

drop table ggircs_swrs.ghgr_import;

commit;

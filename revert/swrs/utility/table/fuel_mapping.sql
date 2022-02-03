-- Revert ggircs:swrs/utility/table/fuel_mapping from pg

begin;

drop table swrs_utility.fuel_mapping;
commit;

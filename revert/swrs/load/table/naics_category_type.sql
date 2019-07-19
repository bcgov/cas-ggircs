-- Revert ggircs:table_naics_category_type from pg

begin;

drop table ggircs_swrs_load.naics_category_type;

commit;

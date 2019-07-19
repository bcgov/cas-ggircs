-- Revert ggircs_swrs:table_naics_naics_category from pg

begin;

drop table ggircs_swrs_load.naics_naics_category;

commit;

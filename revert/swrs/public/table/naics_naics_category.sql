-- Revert ggircs_swrs:table_naics_naics_category from pg

begin;

drop table ggircs.naics_naics_category;

commit;

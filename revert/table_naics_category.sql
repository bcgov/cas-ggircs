-- Revert ggircs_swrs:table_naics_category from pg

begin;

drop table ggircs_swrs.naics_category;

commit;

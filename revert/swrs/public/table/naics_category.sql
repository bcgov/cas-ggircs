-- Revert ggircs_swrs:table_naics_category from pg

begin;

drop table swrs.naics_category;

commit;

-- Revert ggircs:table_naics_category_type from pg

begin;

drop table ggircs_swrs.naics_category_type;

commit;

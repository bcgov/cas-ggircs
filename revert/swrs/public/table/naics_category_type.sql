-- Revert ggircs:table_naics_category_type from pg

begin;

drop table swrs.naics_category_type;

commit;

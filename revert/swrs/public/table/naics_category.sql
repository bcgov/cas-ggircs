-- Revert swrs_transform:table_naics_category from pg

begin;

drop table swrs.naics_category;

commit;

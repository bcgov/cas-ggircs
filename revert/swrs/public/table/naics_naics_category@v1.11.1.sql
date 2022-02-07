-- Revert swrs_transform:table_naics_naics_category from pg

begin;

drop table swrs.naics_naics_category;

commit;

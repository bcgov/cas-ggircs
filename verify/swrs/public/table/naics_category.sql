-- Verify swrs_transform:table_naics_category on pg

begin;

select pg_catalog.has_table_privilege('swrs.naics_category', 'select');

rollback;

-- Verify swrs_transform:ignore_organisation on pg

begin;

select pg_catalog.has_table_privilege('swrs_transform.ignore_organisation', 'select');

rollback;

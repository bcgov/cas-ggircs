-- Verify ggircs_swrs:ignore_organisation on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_transform.ignore_organisation', 'select');

rollback;

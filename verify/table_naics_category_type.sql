-- Verify ggircs:table_naics_category_type on pg

begin;

select pg_catalog.has_table_privilege('ggircs.naics_category_type', 'select');

rollback;

-- Verify ggircs:swrs/public/table/other_venting on pg

begin;

select pg_catalog.has_table_privilege('swrs.other_venting', 'select');

rollback;

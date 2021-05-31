-- Revert ggircs:swrs/transform/materialized_view/report_001 from pg

begin;

update pg_attribute set atttypmod = 1000+4
where attrelid = 'swrs_transform.report'::regclass
and attname = 'update_comment';

commit;

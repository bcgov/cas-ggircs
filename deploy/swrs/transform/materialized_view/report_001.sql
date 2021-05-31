-- Deploy ggircs:swrs/transform/materialized_view/report_001 to pg
-- requires: swrs/transform/materialized_view/report

begin;

-- Changes varchar size of swrs_transform.update_comment to 100000
-- Cannot drop materialized view as other items depend on it, alter materialized view does not support changing datatypes
-- https://stackoverflow.com/questions/7729287/postgresql-change-the-size-of-a-varchar-column-to-lower-length
update pg_attribute set atttypmod = 100000+4
where attrelid = 'swrs_transform.report'::regclass
and attname = 'update_comment';

commit;

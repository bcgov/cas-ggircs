set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_schema('swrs_extract');
select matches(obj_description('swrs_extract'::regnamespace, 'pg_namespace'), '.+', 'Schema swrs_extract has a description');

select finish();
rollback;

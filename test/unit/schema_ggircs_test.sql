set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_schema('ggircs');
select matches(obj_description('ggircs_swrs_load'::regnamespace, 'pg_namespace'), '.+', 'Schema ggircs has a description');

select finish();
rollback;

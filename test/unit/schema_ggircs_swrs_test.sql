set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_schema('ggircs_swrs');
select matches(obj_description('ggircs_swrs'::regnamespace, 'pg_namespace'), '.+', 'Schema ggircs_swrs has a description');

select finish();
rollback;

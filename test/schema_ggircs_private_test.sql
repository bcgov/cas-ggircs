set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_schema('ggircs_private');
select matches(obj_description('ggircs_private'::regnamespace, 'pg_namespace'), '.+', 'Schema ggircs_private has a description');

select finish();
rollback;

set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
-- create schema ggircs_test_fixture;
-- set search_path to ggircs_test_fixture,public;

select plan(4);

/** Check schema compliance **/

-- Check schemas like ggircs%  exist
with schema_names as (select schema_name from information_schema.schemata where schema_name like 'ggircs%')
select has_schema(sch)
from schema_names f(sch);

-- GUIDELINE: Schema has a description
-- Check schema for an existing description (regex '.+')
-- comment on schema ggircs_swrs is 'has a description';
with schema_names as (select schema_name from information_schema.schemata where schema_name like 'ggircs%')
select matches(
               obj_description(sch::regnamespace, 'pg_namespace'),
               '.+',
               format('All schemas have a description. Violation: %I', sch)
           )
from schema_names f(sch);

select *
from finish();

rollback;

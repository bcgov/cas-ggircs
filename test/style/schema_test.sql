set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;

select plan(2);

/** check schema compliance **/

-- check schema exists
select has_schema('ggircs_test_fixture');

-- guideline: schema has a description
  -- check schema for an existing description (regex '.+')
  comment on schema ggircs_test_fixture is 'has a description';
  select matches(
            obj_description('ggircs_test_fixture'::regnamespace, 'pg_namespace'),
            '.+',
            'schema ggircs has a description'
          );

select * from finish();

rollback;

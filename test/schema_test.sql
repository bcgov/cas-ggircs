set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;

select plan(2);

/** Check schema compliance **/

-- TODO: generalize this to check multiple schemas
-- Check schema exists
select has_schema('ggircs_test_fixture');

-- GUIDELINE: Schema has a description
  -- Check schema for an existing description (regex '.+')
  COMMENT ON SCHEMA ggircs_test_fixture IS 'has a description';
  select matches(
            obj_description('ggircs_test_fixture'::regnamespace, 'pg_namespace'),
            '.+',
            'Schema ggircs has a description'
          );

select * from finish();

rollback;

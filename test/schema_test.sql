set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(2);

/** Check schema compliance **/

-- TODO: generalize this to check multiple schemas
-- Check schema exists
select has_schema('ggircs');

-- GUIDELINE: Schema has a description
  -- Check schema for an existing description (regex '.+')
  select matches(
            obj_description('ggircs'::regnamespace, 'pg_namespace'),
            '.+',
            'Schema ggircs has a description'
          );

select * from finish();

rollback;

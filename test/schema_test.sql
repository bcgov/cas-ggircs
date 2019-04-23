SET client_min_messages TO warning;
CREATE extension IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
CREATE schema ggircs_test_fixture;
SET search_path TO ggircs_test_fixture,public;

SELECT plan(2);

/** Check schema compliance **/

-- Check schema exists
SELECT has_schema('ggircs_test_fixture');

-- GUIDELINE: Schema has a description
  -- Check schema for an existing description (regex '.+')
  COMMENT ON SCHEMA ggircs_test_fixture IS 'has a description';
  SELECT matches(
            obj_description('ggircs_test_fixture'::regnamespace, 'pg_namespace'),
            '.+',
            'Schema ggircs has a description'
          );

SELECT * FROM finish();

ROLLBACK;

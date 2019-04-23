SET client_min_messages TO warning;
CREATE extension IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;

CREATE schema ggircs_test_fixture;
SET search_path TO ggircs_test_fixture,public;
CREATE TABLE test_fixture(id SERIAL, fname VARCHAR(50), is_deleted boolean);
INSERT INTO test_fixture(fname, is_deleted) VALUES('Dylan', 'false');

SELECT plan(3);

/** Check Operation Compliance **/

-- GUIDELINE: Hard DELETION of records is not recommended
  -- Soft DELETE the record and set a status or flag to indicate the record is “deleted”. I.e. is_deleted or deleted_ind
  -- Create Rule to satisfy deletion guideline, comment out next 5 lines to test the test
  CREATE RULE no_delete AS ON DELETE TO test_fixture
    DO INSTEAD
    UPDATE test_fixture
      SET is_deleted = true
      WHERE id=1;

  -- Run delete operation
  DELETE FROM test_fixture WHERE fname='Dylan';
  -- Test that the rule exists on all tables in schema
  WITH tnames AS (SELECT table_name FROM information_schema.tables WHERE table_schema = 'ggircs_test_fixture')
  SELECT rule_is_on('ggircs_test_fixture', tbl, 'no_delete', 'DELETE', format('Table has rule no_delete. Violation: %I', tbl))
  FROM tnames f(tbl);
  -- Test that record is not deleted
  SELECT isnt_empty('SELECT fname FROM test_fixture', 'Hard deletion of records is not recommended');
  -- Test that is_deleted flag is set to true
  SELECT results_eq('SELECT is_deleted FROM test_fixture WHERE id=1', array[true], 'Soft DELETE recommended (set is_deleted flag)');

-- TODO: Changes to the data must be able to be audited

ROLLBACK;

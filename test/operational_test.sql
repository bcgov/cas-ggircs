SET client_min_messages TO warning;
CREATE extension IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;

CREATE schema ggircs_test_fixture;
SET search_path TO ggircs_test_fixture,public;
CREATE TABLE test_fixture(id SERIAL, fname VARCHAR(50), is_deleted boolean);
INSERT INTO test_fixture(fname, is_deleted) VALUES('Dylan', 'false');


/** CREATE AUDIT SCHEMA & LOG TABLE **/
CREATE schema audit;
REVOKE CREATE ON schema audit FROM public;

CREATE TABLE audit.logged_actions (
    schema_name text NOT NULL,
    TABLE_NAME text NOT NULL,
    user_name text,
    action_tstamp TIMESTAMP WITH TIME zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    action TEXT NOT NULL CHECK (action IN ('I','D','U')),
    original_data text,
    new_data text,
    query text
) WITH (fillfactor=100);

REVOKE ALL ON audit.logged_actions FROM public;

-- You may wish to use different permissions; this lets anybody
-- see the full audit data. In Pg 9.0 and above you can use column
-- permissions for fine-grained control.
GRANT SELECT ON audit.logged_actions TO public;

CREATE INDEX logged_actions_schema_table_idx
ON audit.logged_actions(((schema_name||'.'||TABLE_NAME)::TEXT));

CREATE INDEX logged_actions_action_tstamp_idx 
ON audit.logged_actions(action_tstamp);

CREATE INDEX logged_actions_action_idx 
ON audit.logged_actions(action);

/** CREATE IF_MODIFIED FUNCTION **/
CREATE OR REPLACE FUNCTION audit.if_modified_func() RETURNS TRIGGER AS $body$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /*  If this actually for real auditing (where you need to log EVERY action),
        then you would need to use something like dblink or plperl that could log outside the transaction,
        regardless of whether the transaction committed or rolled back.
    */
    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */
 
    IF (TG_OP = 'UPDATE') THEN
        v_old_data := ROW(OLD.*);
        v_new_data := ROW(NEW.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,original_data,new_data,query) 
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := ROW(OLD.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,original_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := ROW(NEW.*);
        INSERT INTO audit.logged_actions (schema_name,table_name,user_name,action,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
LANGUAGE plpgsql
SECURITY DEFINER;


SELECT plan(5);

/** Check Operation Compliance **/

-- GUIDELINE: Hard DELETION of records is not recommended
  -- Soft DELETE the record and set a status or flag to indicate the record is “deleted”. I.e. is_deleted or deleted_ind
  -- Create Rule to satisfy deletion guideline, comment out next 5 lines to test the test
  CREATE RULE no_delete AS ON DELETE TO test_fixture
    DO INSTEAD
    UPDATE test_fixture
      SET is_deleted = true
      WHERE id=1;

  -- Create Trigger to satisfy audit guideline (next guideline), comment out next 3 lines to test the test
  CREATE TRIGGER test_fixture_audit
  AFTER INSERT OR UPDATE OR DELETE ON test_fixture
  FOR EACH ROW EXECUTE PROCEDURE audit.if_modified_func();

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

-- GUIDELINE: Changes to the data must be able to be audited
  -- Test that the trigger exists on all tables in schema
  WITH tnames AS (SELECT table_name FROM information_schema.tables WHERE table_schema = 'ggircs_test_fixture')
  SELECT has_trigger('ggircs_test_fixture', tbl, 'test_fixture_audit', format('Table has audit trigger. Violation: %I', tbl))
  FROM tnames f(tbl);
  -- Test that the if_modified function was triggered when data was updated
  SELECT isnt_empty('SELECT * FROM audit.logged_actions');
ROLLBACK;

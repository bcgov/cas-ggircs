SET client_min_messages TO warning;
CREATE extension IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;

CREATE schema ggircs_test_fixture;
SET search_path TO ggircs_test_fixture,public;
CREATE TABLE test_fixture
(
    id        SERIAL,
    name      VARCHAR(50),
    lname     VARCHAR,
    bad$Name  VARCHAR(10),
    badnumber numeric
);
COMMENT ON COLUMN test_fixture.id IS 'has a description';
COMMENT ON COLUMN test_fixture.name IS 'has a description';
COMMENT ON COLUMN test_fixture.bad$name IS 'has a description';
COMMENT ON COLUMN test_fixture.badnumber IS 'has a description';


SELECT plan(1657);

/** Check Column Compliance **/

-- GUIDELINE: DB should have descriptions for all columns
-- Add comment to lname column, comment out next line to test the test
COMMENT ON COLUMN test_fixture.lname IS 'has a description';;
-- Get all columns within schema ggircs_test_fixture that do not have a comment
PREPARE nullComment AS SELECT pg_catalog.col_description(
                                      format('%s.%s', isc.table_schema, isc.table_name)::regclass::oid,
                                      isc.ordinal_position)
                                  as column_description
                       FROM information_schema.columns isc
                       WHERE table_schema = 'ggircs_test_fixture'
                         AND pg_catalog.col_description(
                               format('%s.%s', isc.table_schema, isc.table_name)::regclass::oid,
                               isc.ordinal_position) IS NULL;
-- Test that there are no results on the above query for null comments
SELECT is_empty(
               'nullComment', 'Columns have descriptions'
           );

-- GUIDELINE: Columns must have defined maximums for CHAR columns
-- Drop column lname (has no char max length) comment out to test the test
ALTER TABLE test_fixture
    DROP COLUMN lname;
-- Get all max char lengths from char tables
PREPARE charCol AS SELECT columns.character_maximum_length
                   FROM information_schema.columns
                   WHERE table_schema = 'ggircs_test_fixture'
                     AND data_type LIKE 'char%';
-- Get all nulls from character_maximum_length column
PREPARE nullCol AS SELECT columns.character_maximum_length
                   FROM information_schema.columns
                   WHERE table_schema = 'ggircs_test_fixture'
                     AND character_maximum_length IS NULL;
-- Check there are no nulls for character_max_length when datatype is like 'char%' (INTERSECT ALL charcol <-> nullCol)
SELECT bag_hasnt(
               'charCol', 'nullCol', 'columns have defined maximums'
           );

-- GUIDELINE: Columns must have defined Scale and Precision for NUMERIC columns
-- Drop column lacking precision and scale, add column with (p,s) to satisfy guideline. Comment out next line to test the test
ALTER TABLE test_fixture
    drop badnumber;
ALTER TABLE test_fixture
    ADD goodnumber numeric(6);
-- Get all numeric data types that return null when queried for their precision or scale
PREPARE numericCol AS SELECT columns.numeric_precision, columns.numeric_scale
                      FROM information_schema.columns
                      WHERE table_schema = 'ggircs_test_fixture'
                        AND (data_type LIKE '%int%'
                          OR data_type LIKE '%serial%'
                          OR data_type LIKE 'double%'
                          OR data_type = 'decimal'
                          OR data_type = 'numeric'
                          OR data_type = 'real'
                          )
                        AND (columns.numeric_precision IS NULL OR columns.numeric_scale IS NULL);
-- Check that the result of the above query is empty
SELECT is_empty(
               'numericCol', 'numeric columns have precison and scale'
           );

-- GUIDELINE: Columns must be defined by an accepted data_type
-- Get all colums in schema ggircs that have an undefined data_type
prepare noDataType AS SELECT data_type
                      FROM information_schema.columns
                      WHERE table_schema = 'ggircs_test_fixture'
                        AND data_type IS NULL;
-- Check that the results returned by the above prepared statement are empty (no undefined data_types)
SELECT is_empty('noDataType', 'Columns must be defined by an accepted data_type');

-- GUIDELINE GROUP: Enforce column naming conventions
-- GUIDELINE: Names are lower-case with underscores_as_word_separators
-- Drop column bad$Name to comply with naming guideline, comment out next line to test the test
ALTER TABLE test_fixture
    DROP COLUMN bad$Name;
-- Check that all columns in schema do not return a match of capital letters or non-word characters
WITH cnames AS (SELECT column_name FROM information_schema.columns WHERE table_schema = 'ggircs_test_fixture')
SELECT doesnt_match(
               col,
               '[A-Z]|\W',
               'Column names are lower-case and separated by underscores'
           )
FROM cnames F(col);

-- TODO: Names are singular

-- GUIDELINE: Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
-- Drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
ALTER TABLE test_fixture
    DROP COLUMN name;
-- create table from csv list of reserved words
CREATE TABLE csv_import_fixture
(
    csv_column_fixture TEXT
);
\COPY csv_import_fixture FROM './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
-- test that all tables in schema do not contain any column names that intersect with reserved words csv dictionary
WITH reserved_words AS (SELECT csv_column_fixture FROM csv_import_fixture),
     tnames AS (SELECT table_name FROM information_schema.tables WHERE table_schema = 'ggircs_test_fixture')
SELECT hasnt_column(
               'ggircs_test_fixture',
               tbl,
               word,
               format('Column names avoid reserved keywords. Violation: %I', word)
           )
FROM reserved_words AS wtmp (word)
         CROSS JOIN tnames AS ttmp (tbl);

ROLLBACK;

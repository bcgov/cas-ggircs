set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;
create table test_fixture(id serial, name varchar(50), lname varchar, bad$Name varchar(10));
COMMENT ON COLUMN test_fixture.id IS 'has a description';
COMMENT ON COLUMN test_fixture.name IS 'has a description';

select plan(832);

/** Check Column Compliance **/

-- GUIDELINE: DB should have descriptions for all columns
-- TODO: Automate to test on all columns in schema ggircs, Dynamically get number of columns
  -- Add comment to lname column, comment out next line to test the test
  COMMENT ON COLUMN test_fixture.lname IS 'has a description';
  -- Check all columns (position FROM VALUES) for an existing description (regex '.+')
  select matches(
            col_description('test_fixture'::regclass::oid, pos),
            '.+',
            'Column has a description'
          ) FROM (VALUES(1),(2),(3)) F(pos);

-- GUIDELINE: Columns must have defined maximums for CHAR columns
  -- Drop column lname (has no char max length) comment out to test the test
  ALTER TABLE test_fixture DROP COLUMN lname;
  -- Get all max char lengths from char tables
  prepare charCol as select columns.character_maximum_length
                  from information_schema.columns
                  where table_schema = 'ggircs_test_fixture'
                  and data_type like 'char%';
  -- Get all nulls from character_maximum_length column
  prepare nullCol as select columns.character_maximum_length
                      from information_schema.columns
                      where table_schema = 'ggircs_test_fixture'
                      and character_maximum_length IS NULL;
  -- Check there are no nulls for character_max_length when datatype is like 'char%' (INTERSECT ALL charcol <-> nullCol)
  select bag_hasnt(
            'charCol', 'nullCol', 'columns have defined maximums'
        );

-- TODO: Columns must have defined Scale and Precision for NUMERIC columns

-- GUIDELINE: Columns must be defined by an accepted data_type
  -- Get all colums in schema ggircs that have an undefined data_type
  prepare noDataType as select data_type from information_schema.columns
                  where table_schema='ggircs_test_fixture'
                  and data_type IS NULL;
  -- Check that the results returned by the above prepared statement are empty (no undefined data_types)
  select is_empty('noDataType', 'Columns must be defined by an accepted data_type');

-- TODO: Enforce column naming conventions
        -- GUIDELINE: Names are lower-case with underscores_as_word_separators
        -- TODO: Automate getting all columns from tables
          -- Drop column bad$Name to comply with naming guideline, comment out next line to test the test
          ALTER TABLE test_fixture DROP COLUMN bad$Name;
          -- Check that all columns do not return a match of capital letters or non-word characters
          select doesnt_match(
                  col,
                  '[A-Z]|\W',
                  'Column names are lower-case and separated by underscores'
          ) FROM (VALUES('id'), ('name')) F(col);

        -- TODO: Names are singular

        -- GUIDELINE: Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
          -- Drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
          ALTER TABLE test_fixture DROP COLUMN name;

          -- create table from csv list of reserved words
          create table csv_import_fixture (csv_column_fixture text);
          \copy csv_import_fixture from './reserved.csv' delimiter ',' csv;
          -- test that table does not contain any column names that intersect with reserved words csv dictionary
          WITH reserved_words AS (SELECT csv_column_fixture FROM csv_import_fixture)
          select hasnt_column(
                  'ggircs_test_fixture',
                  'test_fixture',
                  col,
                  format('Column names avoid reserved keywords. Violation: %I', col)
          ) FROM reserved_words F(col);

rollback;

set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;

select plan(834);

/** Check table compliance **/

-- Create test tables
  create table test_fixture(id serial PRIMARY KEY, name varchar(250));
  COMMENT ON TABLE test_fixture IS 'has a description';
  create table TEST_1_fixture(id serial, team varchar(250));
  COMMENT ON TABLE TEST_1_fixture IS 'has a description';
  create table name(id serial, name varchar(250));
  COMMENT ON TABLE name IS 'has a description';

-- Tables [table1, table2...] exist in Schema ggircs
select tables_are('ggircs_test_fixture', array ['test_fixture', 'test_1_fixture', 'name']);

-- GUIDELINE: Schema ggircs should have descriptions for all tables
-- TODO: Dynamically get all tables for schema ggircs
  -- Check all tables for an existing description (regex '.+')
  select matches(
            obj_description(tbl::regclass, 'pg_class'),
            '.+',
            'Table has a description'
          ) FROM (VALUES('test_fixture'), ('test_1_fixture'), ('name')) F(tbl);

--GUIDELINE GROUP: Enforce table naming conventions
        -- GUIDELINE: Names are lower-case with underscores_as_word_separators
        -- TODO: Automate to run on all tables within schema
        -- replacing VALUES with a WITH query could be helpful in dynamically accessing table names

          /** Test code for dynamically getting all tables from schema **/
          prepare names as SELECT table_name FROM information_schema.tables WHERE table_schema = 'ggircs';
          prepare tblnames as SELECT ARRAY(
                                SELECT table_name
                                FROM information_schema.tables
                                WHERE table_schema='ggircs'
                              );
          CREATE table tblnames(tname varchar(50));
          INSERT INTO tblnames(tname) VALUES ('test_fixture'), ('test_fixture'), ('name');
          /** END TEST CODE**/
          
          -- Check that all table names do not return a match of capital letters or non-word characters
          WITH tnames AS (SELECT tname FROM tblnames)
          select doesnt_match(
                tbl,
                '[A-Z]|\W',
                'table names are lower-case and separated by underscores'
        ) FROM tnames F(tbl);

        -- TODO: Names are singular
          -- POSTGRES stemmer
          -- ACTIVE RECORD (Ruby/Rails)

        -- Drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
        DROP TABLE name;
        -- GUIDELINE: Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
        -- TODO create one-column csv to read reserved words from
        create table csv_import_fixture (csv_column_fixture text);
        \copy csv_import_fixture from './reserved.csv' delimiter ',' csv;
        -- TODO: Add full absolute path
        -- copy reserved_words from 'reserved.csv';
        WITH reserved_words AS (SELECT csv_column_fixture FROM csv_import_fixture)
        select hasnt_table(
                'ggircs_test_fixture',
                tbl,
                format('Table names avoid reserved keywords. Violation: %I', tbl)
        ) FROM reserved_words F(tbl);

-- GUIDELINE: All tables must have a unique primary key
-- TODO: Automate to run on all tables in schema ggircs
  -- Add Primary Key to table test_1_fixture (comment out to test the has_pk test)
  ALTER TABLE test_1_fixture ADD PRIMARY KEY (id);
  -- pg_TAP built in test functuon for checking a table has a primary key
  select has_pk(
            'ggircs_test_fixture', tbl, 'Table has Primary key'
          ) FROM (VALUES('test_fixture'), ('test_1_fixture')) F(tbl);

-- TODO: Related tables must have foreign key constraints : FK column names must match PK name from parent

select * from finish();

rollback;

set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;

select plan(834);

/** check table compliance **/

-- create test tables
  create table test_fixture(id serial primary key, name varchar(250));
  comment on table test_fixture is 'has a description';
  create table no_comment_no_pkey_fixture(id serial, team varchar(250));
  create table name(id serial, name varchar(250));
  comment on table name is 'has a description';

-- tables [table1, table2...] exist in schema ggircs
select tables_are('ggircs_test_fixture', array ['test_fixture', 'no_comment_no_pkey_fixture', 'name']);

-- guideline: schema ggircs should have descriptions for all tables
  -- add comment on test_1_fixture to comply with guideline, comment out to test the test
  comment on table no_comment_no_pkey_fixture is 'has a description';
  -- check all tables for an existing description (regex '.+')
  with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
  select matches(
            obj_description(tbl::regclass, 'pg_class'),
            '.+',
            format('Table has a description. Violation: %I', tbl)
          ) from tnames f(tbl);

--guideline group: enforce table naming conventions
  -- TODO: Pull regex into a variable and write a test to verify the validity of the regex
  -- guideline: names are lower-case with underscores_as_word_separators
    -- check that all table names do not return a match of capital letters or non-word characters
    with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
    select doesnt_match(
          tbl,
          '[A-Z]|\W',
          format('Table names are lower-case and separated by underscores. Violation: %I', tbl)
  ) from tnames f(tbl);

  -- TODO: names are singular
    -- postgres stemmer
    -- active record (ruby/rails)

  -- guideline: avoid reserved keywords (ie. comment -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
    -- drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
    drop table name;
    -- create table from csv list of reserved words
    create table csv_import_fixture (csv_column_fixture text);
    \copy csv_import_fixture from './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
    -- test that schema does not contain any table names that intersect with reserved words csv dictionary
    with reserved_words as (select csv_column_fixture from csv_import_fixture)
    select hasnt_table(
            'ggircs_test_fixture',
            tbl,
            format('Table names avoid reserved keywords. Violation: %I', tbl)
    ) from reserved_words f(tbl);
    drop table csv_import_fixture;

-- guideline: all tables must have a unique primary key
  -- add primary key to table test_1_fixture (comment out to test the has_pk test)
  alter table no_comment_no_pkey_fixture add primary key (id);
  -- pg_tap built in test functuon for checking all tables in schema have a primary key
  with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
  select has_pk(
            'ggircs_test_fixture', tbl, format('Table has primary key. Violation: %I', tbl)
          ) from tnames f(tbl);

-- TODO: related tables must have foreign key constraints : fk column names must match pk name from parent

select * from finish();

rollback;

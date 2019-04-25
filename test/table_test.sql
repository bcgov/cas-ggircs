set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;

select plan(834);

/** Check table compliance **/

-- Create test tables
create table test_fixture
(
    id   serial primary key,
    name varchar(250)
);
comment on table test_fixture is 'has a description';
create table no_comment_no_pkey_fixture
(
    id   serial,
    team varchar(250)
);
create table name
(
    id   serial,
    name varchar(250)
);
comment on table name is 'has a description';

-- Tables [table1, table2...] exist in Schema ggircs
select tables_are('ggircs_test_fixture', array ['test_fixture', 'no_comment_no_pkey_fixture', 'name']);

-- GUIDELINE: Schema ggircs should have descriptions for all tables
-- Add comment on test_1_fixture to comply with guideline, comment out to test the test
comment on table no_comment_no_pkey_fixture is 'has a description';
-- Check all tables for an existing description (regex '.+')
with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
select matches(
               obj_description(tbl::regclass, 'pg_class'),
               '.+',
               format('Table has a description. Violation: %I', tbl)
           )
from tnames f(tbl);

--GUIDELINE GROUP: Enforce table naming conventions
-- GUIDELINE: Names are lower-case with underscores_as_word_separators
-- Check that all table names do not return a match of capital letters or non-word characters
with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
select doesnt_match(
               tbl,
               '[A-Z]|\W',
               format('Table names are lower-case and separated by underscores. Violation: %I', tbl)
           )
from tnames f(tbl);

-- TODO: Names are singular
-- POSTGRES stemmer
-- ACTIVE RECORD (Ruby/Rails)

-- GUIDELINE: Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
-- Drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
drop table name;
-- create table from csv list of reserved words
create table csv_import_fixture
(
    csv_column_fixture text
);
\copy csv_import_fixture from './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
-- test that schema does not contain any table names that intersect with reserved words csv dictionary
with reserved_words as (select csv_column_fixture from csv_import_fixture)
select hasnt_table(
               'ggircs_test_fixture',
               tbl,
               format('Table names avoid reserved keywords. Violation: %I', tbl)
           )
from reserved_words f(tbl);
drop table csv_import_fixture;

-- GUIDELINE: All tables must have a unique primary key
-- Add Primary Key to table test_1_fixture (comment out to test the has_pk test)
alter table no_comment_no_pkey_fixture
    add primary key (id);
-- pg_TAP built in test functuon for checking all tables in schema have a primary key
with tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
select has_pk(
               'ggircs_test_fixture', tbl, format('Table has primary key. Violation: %I', tbl)
           )
from tnames f(tbl);

-- TODO: Related tables must have foreign key constraints : FK column names must match PK name from parent

select *
from finish();

rollback;

set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

--TODO: **Will likely need to be updated to include materialized views when looping through all tables**
    -- ie: join table_name and materialized_view_name then loop through the joined result

begin;

-- create schema swrs_transform;
-- TODO: set search_path to change dynamically for each schema, I don't think this will work once
--       schemas other than swrs_transform become populated with tables
--       use this: select table_schema || '.' || table_name
set search_path to swrs,swrs_transform,swrs_extract,swrs_history,ggircs_parameters,public;

select * from no_plan();

/** Check table compliance **/

-- GUIDELINE: All tables should have descriptions
-- Check all tables for an existing description (regex '.+')
with tnames as (select table_name from information_schema.tables
                    where table_schema like 'swrs%'
                     and table_type != 'VIEW'
               )
select matches(
               obj_description(tbl::regclass, 'pg_class'),
               '.+',
               format('Table has a description. Violation: %I', tbl)
           )
from tnames f(tbl);

--GUIDELINE GROUP: Enforce table naming conventions
-- GUIDELINE: Names are lower-case with underscores_as_word_separators
-- Check that all table names do not return a match of capital letters or non-word characters
with tnames as (select table_name from information_schema.tables where table_schema like 'swrs%')
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
-- create table from csv list of reserved words
create table csv_import_fixture
(
    csv_column_fixture text
);
\copy csv_import_fixture from './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
-- test that schema does not contain any table names that intersect with reserved words csv dictionary
with reserved_words as (select csv_column_fixture from csv_import_fixture),
schema_names as (select schema_name from information_schema.schemata where schema_name like 'swrs%')
select hasnt_table(
               sch,
               res,
               format('Table names avoid reserved keywords. Violation: %I', res)
           )
from reserved_words as rtmp (res)
cross join schema_names as stmp (sch);
drop table csv_import_fixture;

-- GUIDELINE: All tables must have a unique primary key
-- pg_TAP built in test functuon for checking all tables in schema have a primary key
with tnames as (select table_name from information_schema.tables where table_schema like 'swrs%' and table_type != 'VIEW')
select has_pk(
               tbl, format('Table has primary key. Violation: %I', tbl)
           )
from tnames f(tbl);

-- TODO: Related tables must have foreign key constraints : FK column names must match PK name from parent

select *
from finish();

rollback;

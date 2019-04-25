set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;
create table test_fixture
(
    id        serial,
    name      varchar(50),
    lname     varchar,
    bad$name  varchar(10),
    badnumber numeric
);
comment on column test_fixture.id is 'has a description';
comment on column test_fixture.name is 'has a description';
comment on column test_fixture.bad$name is 'has a description';
comment on column test_fixture.badnumber is 'has a description';


select plan(1657);

/** Check Column Compliance **/

-- GUIDELINE: DB should have descriptions for all columns
-- Add comment to lname column, comment out next line to test the test
comment on column test_fixture.lname is 'has a description';;
-- Get all columns within schema ggircs_test_fixture that do not have a comment
prepare nullcomment as select pg_catalog.col_description(
                                      format('%s.%s', isc.table_schema, isc.table_name)::regclass::oid,
                                      isc.ordinal_position)
                                  as column_description
                       from information_schema.columns isc
                       where table_schema = 'ggircs_test_fixture'
                         and pg_catalog.col_description(
                               format('%s.%s', isc.table_schema, isc.table_name)::regclass::oid,
                               isc.ordinal_position) is null;
-- Test that there are no results on the above query for null comments
select is_empty(
               'nullcomment', 'columns have descriptions'
           );

-- GUIDELINE: Columns must have defined maximums for CHAR columns
-- Drop column lname (has no char max length) comment out to test the test
alter table test_fixture
    drop column lname;
-- Get all max char lengths from char tables
prepare charcol as select columns.character_maximum_length
                   from information_schema.columns
                   where table_schema = 'ggircs_test_fixture'
                     and data_type like 'char%';
-- Get all nulls from character_maximum_length column
prepare nullcol as select columns.character_maximum_length
                   from information_schema.columns
                   where table_schema = 'ggircs_test_fixture'
                     and character_maximum_length is null;
-- Check there are no nulls for character_max_length when datatype is like 'char%' (INTERSECT ALL charcol <-> nullCol)
select bag_hasnt(
               'charcol', 'nullcol', 'columns have defined maximums'
           );

-- GUIDELINE: Columns must have defined Scale and Precision for NUMERIC columns
-- Drop column lacking precision and scale, add column with (p,s) to satisfy guideline. Comment out next line to test the test
alter table test_fixture
    drop badnumber;
alter table test_fixture
    add goodnumber numeric(6);
-- Get all numeric data types that return null when queried for their precision or scale
prepare numericcol as select columns.numeric_precision, columns.numeric_scale
                      from information_schema.columns
                      where table_schema = 'ggircs_test_fixture'
                        and (data_type like '%int%'
                          or data_type like '%serial%'
                          or data_type like 'double%'
                          or data_type = 'decimal'
                          or data_type = 'numeric'
                          or data_type = 'real'
                          )
                        and (columns.numeric_precision is null or columns.numeric_scale is null);
-- Check that the result of the above query is empty
select is_empty(
               'numericcol', 'numeric columns have precison and scale'
           );

-- GUIDELINE: Columns must be defined by an accepted data_type
-- Get all colums in schema ggircs that have an undefined data_type
prepare nodatatype as select data_type
                      from information_schema.columns
                      where table_schema = 'ggircs_test_fixture'
                        and data_type is null;
-- Check that the results returned by the above prepared statement are empty (no undefined data_types)
select is_empty('nodatatype', 'columns must be defined by an accepted data_type');

-- GUIDELINE GROUP: Enforce column naming conventions
-- GUIDELINE: Names are lower-case with underscores_as_word_separators
-- Drop column bad$Name to comply with naming guideline, comment out next line to test the test
alter table test_fixture
    drop column bad$name;
-- Check that all columns in schema do not return a match of capital letters or non-word characters
with cnames as (select column_name from information_schema.columns where table_schema = 'ggircs_test_fixture')
select doesnt_match(
               col,
               '[A-Z]|\W',
               'column names are lower-case and separated by underscores'
           )
from cnames f(col);

-- TODO: Names are singular

-- GUIDELINE: Avoid reserved keywords (ie. COMMENT -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
-- Drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
alter table test_fixture
    drop column name;
-- create table from csv list of reserved words
create table csv_import_fixture
(
    csv_column_fixture text
);
\copy csv_import_fixture from './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
-- test that all tables in schema do not contain any column names that intersect with reserved words csv dictionary
with reserved_words as (select csv_column_fixture from csv_import_fixture),
     tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
select hasnt_column(
               'ggircs_test_fixture',
               tbl,
               word,
               format('Column names avoid reserved keywords. Violation: %I', word)
           )
from reserved_words as wtmp (word)
         cross join tnames as ttmp (tbl);

rollback;

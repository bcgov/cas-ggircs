set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

create schema ggircs_test_fixture;
set search_path to ggircs_test_fixture,public;
create table test_fixture(id serial, name varchar(50), lname varchar, bad$name varchar(10), bad_number numeric);
comment on column test_fixture.id is 'has a description';
comment on column test_fixture.name is 'has a description';
comment on column test_fixture.bad$name is 'has a description';
comment on column test_fixture.bad_number is 'has a description';


select plan(1657);

/** check column compliance **/

-- guideline: db should have descriptions for all columns
  -- add comment to lname column, comment out next line to test the test
  comment on column test_fixture.lname is 'has a description';
  -- get all columns within schema ggircs_test_fixture that do not have a comment
  prepare null_comment as select pg_catalog.col_description(format('%s.%s',isc.table_schema,isc.table_name)::regclass::oid,isc.ordinal_position)
            as column_description
            from information_schema.columns isc
            where table_schema='ggircs_test_fixture'
            and pg_catalog.col_description(format('%s.%s',isc.table_schema,isc.table_name)::regclass::oid,isc.ordinal_position) is null;
  -- test that there are no results on the above query for null comments
  select is_empty(
            'null_comment', 'Columns have descriptions'
            );

-- guideline: columns must have defined maximums for char columns
  -- drop column lname (has no char max length) comment out to test the test
  alter table test_fixture drop column lname;
  -- get all max char lengths from char tables
  prepare char_col as select columns.character_maximum_length
                  from information_schema.columns
                  where table_schema = 'ggircs_test_fixture'
                  and data_type like 'char%';
  -- get all nulls from character_maximum_length column
  prepare null_col as select columns.character_maximum_length
                      from information_schema.columns
                      where table_schema = 'ggircs_test_fixture'
                      and character_maximum_length is null;
  -- check there are no nulls for character_max_length when datatype is like 'char%' (intersect all char_col <-> null_col)
  select bag_hasnt(
            'char_col', 'null_col', 'Columns have defined maximums'
        );

-- guideline: columns must have defined scale and precision for numeric columns
  -- drop column lacking precision and scale, add column with (p,s) to satisfy guideline. comment out next line to test the test
  alter table test_fixture drop bad_number;
  alter table test_fixture add good_number numeric(6);
  -- get all numeric data types that return null when queried for their precision or scale
  prepare numeric_col as select columns.numeric_precision, columns.numeric_scale
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
  -- check that the result of the above query is empty
  select is_empty(
            'numeric_col', 'Numeric columns have precison and scale'
  );

-- guideline: columns must be defined by an accepted data_type
  -- get all colums in schema ggircs that have an undefined data_type
  prepare no_data_type as select data_type from information_schema.columns
                  where table_schema='ggircs_test_fixture'
                  and data_type is null;
  -- check that the results returned by the above prepared statement are empty (no undefined data_types)
  select is_empty('no_data_type', 'columns must be defined by an accepted data_type');

-- guideline group: enforce column naming conventions
        -- TODO: Pull regex into a variable and write a test to verify the validity of the regex
        -- guideline: names are lower-case with underscores_as_word_separators
          -- drop column bad$name to comply with naming guideline, comment out next line to test the test
          alter table test_fixture drop column bad$name;
          -- check that all columns in schema do not return a match of capital letters or non-word characters
          with cnames as (select column_name from information_schema.columns where table_schema = 'ggircs_test_fixture')
          select doesnt_match(
                  col,
                  '[A-Z]|\W',
                  'column names are lower-case and separated by underscores'
          ) from cnames f(col);

        -- TODO: names are singular

        -- guideline: avoid reserved keywords (ie. comment -> [name]_comment) https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words
          -- drop table 'name' to comply with reserved keywords guideline, comment out next line to test the test
          alter table test_fixture drop column name;
          -- create table from csv list of reserved words
          create table csv_import_fixture (csv_column_fixture text);
          \copy csv_import_fixture from './test/fixture/sql_reserved_words.csv' delimiter ',' csv;
          -- test that all tables in schema do not contain any column names that intersect with reserved words csv dictionary
          with reserved_words as (select csv_column_fixture from csv_import_fixture),
          tnames as (select table_name from information_schema.tables where table_schema = 'ggircs_test_fixture')
          select hasnt_column(
                  'ggircs_test_fixture',
                  tbl,
                  word,
                  format('Column names avoid reserved keywords. Violation: %I', word)
          ) from reserved_words as wtmp (word)
          cross join tnames as ttmp (tbl);

rollback;

set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

select has_table('ggircs_private', 'raw_report', 'Table raw_report exists');

select has_column('ggircs_private', 'raw_report', 'id', 'Table has column: id');
select col_is_pk('ggircs_private', 'raw_report', 'id', 'Column: id is Primary Key');
select has_column('ggircs_private', 'raw_report', 'xml_file', 'Table has column: xml_file');
select has_column('ggircs_private', 'raw_report', 'imported_at', 'Table has column: imported_at');

select finish();
rollback;

-- Deploy ggircs:table_report_schema_diff to pg

begin;

create table swrs_extract.report_schema_diff (
  id integer generated always as identity primary key,
  report_name varchar(1000) not null,
  new_node varchar(1000) not null,
  created_at timestamp with time zone not null default now()
);

create unique index idx_report_name_new_node
on swrs_extract.report_schema_diff(report_name, new_node);
comment on table  swrs_extract.report_schema_diff is 'Table that records deviation from the schema for a report';
comment on column swrs_extract.report_schema_diff.id is 'The internal primary key for the row';
comment on column swrs_extract.report_schema_diff.new_node is 'The new node in the report that doesnt exist in the schema';
comment on column swrs_extract.report_schema_diff.created_at is 'The timestamp noting when the row was created';

commit;

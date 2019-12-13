-- Deploy ggircs:table_log to pg

begin;

create table swrs_extract.log (
  id integer generated always as identity primary key,
  report_name varchar(1000) not null,
  log varchar(100000) not null,
  created_at timestamp with time zone not null default now()
);

comment on table  swrs_extract.log is 'Table that logs exceptions and events during extraction';
comment on column swrs_extract.log.report_name is 'The file name that is being extracted';
comment on column swrs_extract.log.id is 'The internal primary key for the row';
comment on column swrs_extract.log.log is 'The exception or event';
comment on column swrs_extract.log.created_at is 'The timestamp noting when the row was created';

commit;

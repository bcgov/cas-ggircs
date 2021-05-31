-- Deploy ggircs:swrs/public/table/report_001 to pg
-- requires: swrs/public/table/report

begin;

alter table swrs.report alter column update_comment type varchar (100000);

commit;

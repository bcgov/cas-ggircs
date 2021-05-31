-- Revert ggircs:swrs/public/table/report_001 from pg

begin;

alter table swrs.report alter column update_comment type varchar (1000);

commit;

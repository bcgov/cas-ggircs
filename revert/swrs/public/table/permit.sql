-- Revert ggircs:table_permit from pg

begin;

drop table swrs.permit;

commit;

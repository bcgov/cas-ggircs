-- Revert ggircs:table_permit from pg

begin;

drop table ggircs.permit;

commit;

-- Revert ggircs:table_contact from pg

begin;

drop table ggircs.contact;

commit;

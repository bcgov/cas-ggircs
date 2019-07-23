-- Revert ggircs:table_contact from pg

begin;

drop table swrs.contact;

commit;

-- Revert ggircs:ciip_table_contact from pg

begin;

drop table ciip.contact;

commit;


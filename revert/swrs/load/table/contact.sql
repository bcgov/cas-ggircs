-- Revert ggircs:table_contact from pg

begin;

drop table ggircs_swrs_load.contact;

commit;

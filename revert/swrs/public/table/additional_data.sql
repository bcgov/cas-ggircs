-- Revert ggircs:table_descriptor from pg

begin;

drop table swrs.additional_data;

commit;

-- Revert ggircs:table_descriptor from pg

begin;

drop table ggircs_swrs_load.additional_data;

commit;

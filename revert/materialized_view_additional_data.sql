-- Revert ggircs:materialized_view_descriptors from pg

begin;

drop materialized view ggircs_swrs.additional_data;

commit;

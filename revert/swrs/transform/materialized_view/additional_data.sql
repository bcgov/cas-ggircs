-- Revert ggircs:materialized_view_descriptors from pg

begin;

drop materialized view ggircs_swrs_transform.additional_data;

commit;

-- Revert ggircs:materialized_view_descriptors from pg

begin;

drop materialized view swrs_transform.additional_data;

commit;

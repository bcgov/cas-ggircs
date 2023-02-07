-- Revert ggircs:swrs/transform/materialized_view/other_venting from pg

begin;

drop materialized view swrs_transform.other_venting;

commit;

-- Revert ggircs:swrs/transform/function/load_other_venting from pg

begin;

drop function swrs_transform.other_venting;

commit;

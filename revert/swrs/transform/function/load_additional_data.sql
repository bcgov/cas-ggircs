-- Revert ggircs:function_load_additional_data from pg

begin;

drop function ggircs_swrs_transform.load_additional_data;

commit;

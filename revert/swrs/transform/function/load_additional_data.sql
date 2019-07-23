-- Revert ggircs:function_load_additional_data from pg

begin;

drop function swrs_transform.load_additional_data;

commit;

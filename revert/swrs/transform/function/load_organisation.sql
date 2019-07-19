-- Revert ggircs:function_load_organisation from pg

begin;

drop function ggircs_swrs_transform.load_organisation;

commit;

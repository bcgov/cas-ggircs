-- Revert ggircs:function_load_facility from pg

begin;

 drop function swrs_transform.load_facility;

commit;

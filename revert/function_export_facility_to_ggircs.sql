-- Revert ggircs:function_export_facility_to_ggircs from pg

begin;

 drop function ggircs_swrs.export_facility_to_ggircs;

commit;

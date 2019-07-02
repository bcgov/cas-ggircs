-- Revert ggircs:function_export_naics_to_ggircs from pg

begin;

drop function ggircs_swrs.export_naics_to_ggircs;

commit;

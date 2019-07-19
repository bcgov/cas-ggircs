-- Verify ggircs:view_attributable_emission on pg

begin;

select * from ggircs_swrs_load.attributable_emission where false;

rollback;

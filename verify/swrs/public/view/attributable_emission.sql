-- Verify ggircs:view_attributable_emission on pg

begin;

select * from ggircs.attributable_emission where false;

rollback;

-- Verify ggircs:view_attributable_emission on pg

begin;

select * from swrs.attributable_emission where false;

rollback;

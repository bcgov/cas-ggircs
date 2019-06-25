-- Verify ggircs:view_naics_mapping on pg

begin;

select * from ggircs.naics_mapping where false;

commit;

-- Verify ggircs:swrs/public/view/naics_naics_category on pg

begin;

  select * from swrs.naics_naics_category where false;

rollback;

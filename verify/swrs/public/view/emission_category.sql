-- Verify ggircs:swrs/public/view/emission_category on pg

begin;

  select * from swrs.emission_category where false;

rollback;

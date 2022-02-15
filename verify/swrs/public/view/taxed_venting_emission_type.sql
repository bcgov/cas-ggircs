-- Verify ggircs:swrs/public/view/taxed_venting_emission_type on pg

begin;

  select * from swrs.taxed_venting_emission_type where false;

rollback;

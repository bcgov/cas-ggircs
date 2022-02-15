-- Revert ggircs:swrs/public/view/taxed_venting_emission_type from pg

begin;

drop view if exists swrs.taxed_venting_emission_type;

commit;

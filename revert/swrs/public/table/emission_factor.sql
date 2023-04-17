-- Revert ggircs-portal:tables/emission_factor from pg

begin;

drop table swrs.emission_factor;

commit;
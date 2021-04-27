-- Revert ggircs:private/prune_test_organisations_and_facilities from pg

begin;

drop function swrs_private.prune_test_organisations_and_facilities;

commit;

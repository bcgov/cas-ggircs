-- Revert ggircs:swrs/add_missing_indices from pg

begin;

-- No revert necessary, deploy migration is idempotent.

commit;

-- Verify ggircs:swrs/add_missing_indices on pg

begin;

-- No verify necessary. The existence of an index for each foreign key is ensured via a pgTap test.

rollback;

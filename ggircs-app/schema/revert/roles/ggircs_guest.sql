-- Revert ggircs-app:roles/ggircs_guest from pg

begin;

-- The create roles affects the server globally. Cannot drop the roles once created.
-- This affects development enviroments, where dev and test databases are in the same postgres instance
select true;

commit;

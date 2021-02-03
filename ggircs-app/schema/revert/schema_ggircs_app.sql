-- Revert ggircs-app:schema_ggircs_app from pg

begin;

drop schema ggircs_app;
commit;

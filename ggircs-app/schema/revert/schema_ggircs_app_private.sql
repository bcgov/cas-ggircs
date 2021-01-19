-- Revert ggircs-app:schema_ggircs_app_private from pg

begin;

drop schema ggircs_app_private;
commit;

-- Revert ggircs-app:roles/grant_schemas_usage from pg

begin;

revoke usage on schema ggircs_app from ggircs_user, ggircs_guest;
revoke usage on schema ggircs_app_private from ggircs_user;

commit;

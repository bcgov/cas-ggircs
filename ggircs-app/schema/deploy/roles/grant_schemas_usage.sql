-- Deploy ggircs-app:roles/grant_schemas_usage to pg

begin;

grant usage on schema ggircs_app to ggircs_user, ggircs_guest;
grant usage on schema ggircs_app_private to ggircs_user;

commit;

-- Revert ggircs-app:mutations/create_ggircs_user_from_session from pg

begin;

drop function ggircs_app.create_ggircs_user_from_session;

commit;

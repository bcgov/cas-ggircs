-- Revert ggircs-app:functions/session from pg
begin;

drop function if exists ggircs_app.session;

commit;

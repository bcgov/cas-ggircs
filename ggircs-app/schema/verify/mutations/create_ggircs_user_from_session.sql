-- Verify ggircs-app:mutations/create_ggircs_user_from_session on pg

begin;

select pg_get_functiondef('ggircs_app.create_ggircs_user_from_session()'::regprocedure);

rollback;

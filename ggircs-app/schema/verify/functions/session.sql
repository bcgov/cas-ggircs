-- Verify ggircs-app:functions/session on pg

begin;

select pg_get_functiondef('ggircs_app.session()'::regprocedure);

rollback;

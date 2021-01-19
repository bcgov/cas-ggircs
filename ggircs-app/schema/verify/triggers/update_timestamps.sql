-- Verify ggircs-app:triggers/update_timestamps on pg

begin;

select pg_get_functiondef('ggircs_app.update_timestamps()'::regprocedure);

rollback;

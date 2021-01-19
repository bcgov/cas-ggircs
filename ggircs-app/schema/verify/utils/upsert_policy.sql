-- Verify ggircs-app:policies/functions/upsert_policy on pg

begin;

select pg_get_functiondef('ggircs_app_private.upsert_policy(text,text,text,text,text)'::regprocedure);
select pg_get_functiondef('ggircs_app_private.upsert_policy(text,text,text,text,text,text)'::regprocedure);

rollback;

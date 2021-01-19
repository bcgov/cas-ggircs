-- Verify ggircs-app:utils/grant_permissions on pg

begin;

select pg_get_functiondef('ggircs_app_private.grant_permissions(text,text,text)'::regprocedure);
select pg_get_functiondef('ggircs_app_private.grant_permissions(text,text,text,text[])'::regprocedure);

rollback;

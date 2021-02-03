-- Verify ggircs-app:roles/ggircs_app on pg

begin;

select true from pg_roles where rolname='ggircs_app';

rollback;

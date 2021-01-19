-- Verify ggircs-app:roles/ggircs_user on pg

begin;

select true from pg_roles where rolname='ggircs_user';

rollback;
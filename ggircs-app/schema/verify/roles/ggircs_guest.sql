-- Verify ggircs-app:roles/ggircs_guest on pg

begin;

select true from pg_roles where rolname='ggircs_guest';

rollback;
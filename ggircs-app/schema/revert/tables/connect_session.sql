-- Revert ggircs-app:tables/connect-session from pg

begin;

drop table ggircs_app_private.connect_session;

commit;
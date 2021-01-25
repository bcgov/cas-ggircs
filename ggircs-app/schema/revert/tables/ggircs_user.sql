-- Revert ggircs-app:tables/ggircs_user from pg

begin;

drop table ggircs_app.ggircs_user;

commit;

-- Deploy ggircs-app:tables/ggircs_user to pg

begin;

drop trigger ggircs_user_session_sub_immutable_with_flag;
alter table ggircs_app.ggircs_user drop column allow_sub_update;


-- Dropping existing policies that depend on the text
drop policy ggircs_user_insert_ggircs_user on ggircs_app.ggircs_user;
drop policy ggircs_user_update_ggircs_user on ggircs_app.ggircs_user;

alter table ggircs_app.ggircs_user alter column session_sub type uuid using session_sub::uuid;
alter table ggircs_app.ggircs_user rename column session_sub to uuid;

alter index ggircs_app.ggircs_user_session_sub rename to ggircs_user_uuid;

-- Rebuilding policies with the proper session_sub reference
-- Casting in the check preserves the functionality
do
$policy$
begin
  perform ggircs_app_private.upsert_policy('ggircs_user_insert_ggircs_user', 'ggircs_user', 'insert', 'ggircs_user', 'uuid::text=(select sub from ggircs_app.session())::text');
  perform ggircs_app_private.upsert_policy('ggircs_user_update_ggircs_user', 'ggircs_user', 'update', 'ggircs_user', 'uuid::text=(select sub from ggircs_app.session())::text');
end
$policy$;

comment on column ggircs_app.ggircs_user.uuid is 'Universally Unique ID for the user, defined by the single sign-on provider';

commit;

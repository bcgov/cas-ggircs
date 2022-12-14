-- Deploy ggircs-app:tables/ggircs_user to pg

begin;

-- Dropping existing policies that depend on the uuid
drop policy ggircs_user_insert_ggircs_user on ggircs_app.ggircs_user;
drop policy ggircs_user_update_ggircs_user on ggircs_app.ggircs_user;

alter table ggircs_app.ggircs_user alter column uuid type varchar(1000);
alter table ggircs_app.ggircs_user rename column uuid to session_sub;

-- Postgres rebuilds indexes when renaming columns and changing their types,
-- but does not change their name
alter index ggircs_app.ggircs_user_uuid rename to ggircs_user_session_sub;

-- Necessary index for the email conflict
create unique index ggircs_app_user_email_address on ggircs_app.ggircs_user(email_address);

-- Rebuilding policies with the proper session_sub reference
do
$policy$
begin
  perform ggircs_app_private.upsert_policy('ggircs_user_insert_ggircs_user', 'ggircs_user', 'insert', 'ggircs_user', 'session_sub=(select sub from ggircs_app.session())');
  perform ggircs_app_private.upsert_policy('ggircs_user_update_ggircs_user', 'ggircs_user', 'update', 'ggircs_user', 'session_sub=(select sub from ggircs_app.session())');
end
$policy$;


alter table ggircs_app.ggircs_user
  add column allow_sub_update boolean not null default false;

create trigger ggircs_user_session_sub_immutable_with_flag
    before update of session_sub on ggircs_app.ggircs_user
    for each row
    execute function ggircs_app_private.user_session_sub_immutable_with_flag_set();

-- Allowing all the existing users to update the sub once.
update ggircs_app.ggircs_user set allow_sub_update = true;

comment on column ggircs_app.ggircs_user.allow_sub_update is 'Boolean value determines whether a legacy user can be updated. Legacy users may be updated only once.';
comment on column ggircs_app.ggircs_user.session_sub is 'Unique ID for the user/provider combination, defined by the single sign-on provider.';

commit;

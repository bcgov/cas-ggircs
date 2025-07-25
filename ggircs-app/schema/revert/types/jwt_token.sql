-- Revert ggircs-app:types/jwt_token from pg

begin;

-- Drop dependent policies BEFORE altering the type
drop policy if exists ggircs_user_insert_ggircs_user on ggircs_app.ggircs_user;
drop policy if exists ggircs_user_update_ggircs_user on ggircs_app.ggircs_user;

-- Now revert the type change
alter type ggircs_app.jwt_token alter attribute sub type uuid;

comment on type ggircs_app.jwt_token is E'@primaryKey sub\n@foreignKey (sub) references ggircs_user (uuid)';

commit;

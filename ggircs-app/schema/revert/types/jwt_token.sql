-- Deploy ggircs-app:types/jwt_token to pg


begin;

alter type ggircs_app.jwt_token alter attribute sub type uuid;

comment on type ggircs_app.jwt_token is E'@primaryKey sub\n@foreignKey (sub) references ggircs_user (uuid)';

commit;

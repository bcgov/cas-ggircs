-- Revert ggircs-app:types/jwt_token from pg

begin;

drop type ggircs_app.jwt_token;

commit;

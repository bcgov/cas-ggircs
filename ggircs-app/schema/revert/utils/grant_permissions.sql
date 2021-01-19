-- Revert ggircs-app:utils/grant_permissions from pg

begin;
  drop function ggircs_app_private.grant_permissions(text, text, text);
  drop function ggircs_app_private.grant_permissions(text, text, text, text[]);
commit;
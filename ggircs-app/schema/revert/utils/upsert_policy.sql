-- Revert ggircs-app:utils/upsert_policy from pg

begin;

drop function ggircs_app_private.upsert_policy(text, text, text, text, text);
drop function ggircs_app_private.upsert_policy(text, text, text, text, text, text);

commit;

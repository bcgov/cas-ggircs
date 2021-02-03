-- Revert ggircs-app:triggers/update_timestamps from pg

begin;

drop function ggircs_app_private.update_timestamps;

commit;

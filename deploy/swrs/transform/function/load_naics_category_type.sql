-- Deploy ggircs:swrs/transform/function/load_naics_category_type to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/naics_category_type

BEGIN;

create or replace function swrs_transform.load_naics_category_type()
  returns void as
$function$
    begin

    insert into swrs_load.naics_category_type (naics_category_type, description) values ('hhw', $$Hilary's high level category type$$);
    insert into swrs_load.naics_category_type (naics_category_type, description) values ('irc', 'Industrial Reporting Category sector');
    end
$function$ language plpgsql volatile;
COMMIT;

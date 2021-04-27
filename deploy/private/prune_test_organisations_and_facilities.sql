-- Deploy ggircs:private/prune_test_organisations_and_facilities to pg

begin;

create or replace function swrs_private.prune_test_organisations_and_facilities()
returns void as
$function$
  -- deleting the xml files first to satisfy foreign key constraints
  delete from swrs_extract.eccc_xml_file where zip_file_id in
    (select id from swrs_extract.eccc_zip_file where zip_file_name not like 'GHGBC_PROD_%');

  -- deleting the zip files
  delete from swrs_extract.eccc_zip_file where zip_file_name not like 'GHGBC_PROD_%';
$function$ language sql;

select swrs_private.prune_test_organisations_and_facilities();

commit;

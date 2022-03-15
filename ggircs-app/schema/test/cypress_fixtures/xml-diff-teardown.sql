begin;

truncate swrs_extract.eccc_zip_file restart identity cascade;
truncate swrs_extract.eccc_xml_file restart identity cascade;
truncate swrs_history.report restart identity cascade;

commit;

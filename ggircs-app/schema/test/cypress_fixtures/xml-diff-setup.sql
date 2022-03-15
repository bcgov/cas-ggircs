begin;

grant usage on schema swrs_history to ggircs_user;
grant usage on schema swrs_extract to ggircs_user;
grant select on all tables in schema swrs_history to ggircs_user;
grant select on all tables in schema swrs_extract to ggircs_user;

insert into swrs_extract.eccc_zip_file(zip_file_name)
values ('ZIPPITY_1'), ('DIPPITY_2'), ('BIPPITY_3'), ('ZIPPITY_4');

insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, zip_file_id)
values
('<Report><id>1</id><type>R</type><grade>F</grade><xmen><nightcrawler>true</nightcrawler></xmen></Report>', 'XML REPORT ONE', 1),
('<Report><id>2</id><type>R</type><grade>F</grade><xmen><nightcrawler>false</nightcrawler></xmen></Report>', 'XML REPORT TWO', 2),
('<Report><id>1</id><type>R</type><grade>F</grade><xmen><nightcrawler>true</nightcrawler></xmen></Report>', 'XML REPORT THREE', 3),
('<Report><id>2</id><type>R</type><grade>F</grade><xmen><nightcrawler>false</nightcrawler></xmen></Report>', 'XML REPORT FOUR', 4);

insert into swrs_history.report(id, eccc_xml_file_id, swrs_report_id, submission_date)
values (1,1,1, now()), (2,2,2, now()), (3,3,3, now()), (4,4,4, now());

commit;

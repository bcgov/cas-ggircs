
# Test that process_zip_file
# - opens a zip file and creates a record in swrs_extract.eccc_zip_file
# - for each file in this zip file:
#    - if the file is xml => new record in swrs_extract.eccc_xml_file
#    - otherwise => new record in swrs_extract.eccc_attachments


def test_process_zip_file():
    pass

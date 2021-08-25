"""
This script lists the zip files contained in the swrs_extract.eccc_zip_file table, and,
for each record where attachments_extracted is false, lists the attachments contained in the zip file and
inserts a record into the swrs_extract.eccc_attachment table for each attachment.
"""

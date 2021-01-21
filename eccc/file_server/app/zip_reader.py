import zipfile

class ZipReader:

  def list_file_contents(zip_file):
    with zipfile.ZipFile(zip_file) as unzipped:
      content_list = unzipped.namelist()
      return  content_list

  def extract_file_content(zip_file, path):
    pass
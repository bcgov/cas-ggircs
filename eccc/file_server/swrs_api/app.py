from dotenv import load_dotenv
import os
from flask import Flask, Response, jsonify, make_response, stream_with_context, request
from smart_open import open
import google
import logging

from . import download_service
from . import gcs_bucket_service
from .zip_reader import ZipReader
from urllib.parse import unquote


load_dotenv()
logging.basicConfig(format='%(asctime)s | %(name)s | %(levelname)s: %(message)s')
log = logging.getLogger("App")


app = Flask(__name__)

@app.route('/')
def index():
  return '''
  <!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>GIIRCS internal API server</title>
    </head>
    <body>
      <p>
      When sending a GET request to /files <br>
          - the server responds with a JSON array with objects such as { name: "", size: "", created_at: ""}, listing all of the files in the bucket <br>
      When sending a GET request to /files/{filename}/ <br>
          - the server responds with a JSON object with objects such as { name: "", size: "", created_at: "", files: ["file1", "file2", ... ]}, listing all of the files in the zip file <br>
      When sending a GET request to /files/{filename}/download <br>
          - the server responds with the file filename contained in the bucket <br>
      When sending a GET request to /files/{filename}/download?file_path={urlencoded_path} <br>
          - the server responds with the file contained in the zip file 
      </p>
    </body>
  </html>
  '''

def make_200_response(data):
  headers = {"Content-Type": "application/json"}
  return make_response(
    jsonify(data),
    200,
    headers
  )
def make_error_response(msg, html_response_code):
  headers = {"Content-Type": "application/json"}
  return make_response(
    jsonify({"error":msg, "code": html_response_code}),
    html_response_code,
    headers
  )


@app.route('/files')
def list_files_in_bucket():
  bucket_name = os.environ.get('BUCKET_NAME')
  bucket_service = gcs_bucket_service.GcsBucketService(bucket_name)
  zip_blobs = bucket_service.list_zip_blobs()

  def build_response_object(blob):
    return {
      'name': blob.name,
      'size': blob.size / (1024*1024),
      'created_at': blob.time_created
    }
  file_data = [build_response_object(blob) for blob in zip_blobs]
  
  return make_200_response(file_data)



@app.route('/files/<string:blob_name>')
def list_file_contents(blob_name):
  bucket_name = os.environ.get('BUCKET_NAME')
  bucket_service = gcs_bucket_service.GcsBucketService(bucket_name)

  blob = bucket_service.get_zip_blob(blob_name)

  file_path = bucket_service.get_file_url(blob_name)

  try:
    with open(file_path, 'rb') as file_to_unzip:
      content_list = ZipReader.list_file_contents(file_to_unzip)
      data = {
        "zip_file_name": blob_name,
        "zip_file_content_count": len(content_list),
        "zip_file_size": blob.size / (1024*1024),
        "zip_content_list": content_list        
      }
      return make_200_response(data)
  except(google.api_core.exceptions.NotFound):
    return make_error_response('File not found on GCS', 404)

@app.route('/files/<string:blob_name>/download')
def download(blob_name):
  internal_file_path = request.args.get('filename')
  
  bucket_name = os.environ.get('BUCKET_NAME')
  bucket_service = gcs_bucket_service.GcsBucketService(bucket_name)

  file_path = bucket_service.get_file_url(blob_name)

  if not internal_file_path:
    # We return the whole zip file, in chunks
    blob = bucket_service.get_zip_blob(blob_name)
    headers = {
      'Content-Length': blob.size,
      'Content-Disposition': f'attachment; filename={blob_name}'
    }
    return Response(stream_with_context(download_service.DownloadService.generator(file_path)), mimetype='application/zip', headers=headers)
  
  else:    
    decoded_path = unquote(internal_file_path)
        
    with open(file_path, 'rb') as file_descriptor:
      internal_file_bytes = ZipReader.extract_file_content(file_descriptor, decoded_path)

    download_name = decoded_path.replace('/','-')

    headers = {
      'Content-Length': len(internal_file_bytes),
      'Content-Disposition': f'attachment; filename={download_name}'
    }
    return Response(internal_file_bytes, mimetype='application/object', headers=headers)
  


if __name__ == '__main__':
  app.run(debug=('DEBUG' in os.environ), threaded=True)

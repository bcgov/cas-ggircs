from dotenv import load_dotenv
import os
from flask import Flask, jsonify, make_response
from smart_open import smart_open as open
import google

from .gcs_bucket_service import GcsBucketService
from .zip_reader import ZipReader

load_dotenv()

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
      When sending a GET request to /files/{filename}/download?file_path?{urlencoded_path} <br>
          - the server responds with the file contained in the zip file 
      </p>
    </body>
  </html>
  '''

def make_200_json_response(data):
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
  bucket_service = GcsBucketService(bucket_name)
  zip_blobs = bucket_service.list_zip_blobs()

  def build_response_object(blob):
    return {
      'name': blob.name,
      'size': blob.size / (1024*1024),
      'created_at': blob.time_created
    }
  file_data = [build_response_object(blob) for blob in zip_blobs]
  
  return make_200_json_response(file_data)

@app.route('/files/<string:blob_name>')
def list_file_contents(blob_name):
  bucket_name = os.environ.get('BUCKET_NAME')
  bucket_service = GcsBucketService(bucket_name)

  file_path = bucket_service.get_file_url(blob_name)

  try:
    with open(file_path, 'rb') as file_to_unzip:
      content_list = ZipReader.list_file_contents(file_to_unzip)
      data = {
        "zip_file_name":blob_name,
        "zip_count":len(content_list),
        "zip_list":content_list
      }
      return make_200_json_response(data)
  except(google.api_core.exceptions.NotFound):
    return make_error_response('File not found on GCS', 404)
  except:
    make_error_response('Error processing the requested file', 500)

if __name__ == '__main__':
  app.run(debug=True)
  
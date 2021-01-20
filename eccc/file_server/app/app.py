from dotenv import load_dotenv
from .gcs_bucket_service import GcsBucketService
import os
from flask import Flask, jsonify, make_response

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

@app.route('/files')
def list_files_in_bucket():
  bucket_name = os.environ.get('BUCKET_NAME')
  bucket_service = GcsBucketService(bucket_name)
  file_data = bucket_service.list_files()
  
  return make_200_json_response(file_data)

@app.route('/files/<string:blob_name>')
def list_file_contents(blob_name):
  pass


if __name__ == '__main__':
  app.run(debug=True)
  
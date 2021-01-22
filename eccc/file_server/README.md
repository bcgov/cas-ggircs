GCS Zip File Server
===================

This is a tiny python Flask app that serves a few endpoints to be used internally by the CAS infrastructure.

##### Endpoints served:

GET request to `/files` <br>
    > the server responds with a JSON array with objects such as { name: "", size: "", created_at: ""}, listing all of the files in the bucket<br>
GET request to `/files/{filename}/`<br>
    > the server responds with a JSON object with objects such as { name: "", size: "", created_at: "", files: ["file1", "file2", ... ]}, listing all of the files in the zip file<br>
GET request to `/files/{filename}/download`<br>
    > the server responds with the file filename contained in the bucket<br>
GET request to `/files/{filename}/download?file_path?{urlencoded_path}`<br>
    > the server responds with the file contained in the zip file <br>


Running the container
---------------------
0. Navigate to the `./eccc/file_server` path where the dockerfile is located <br>
  `cd eccc/file_server` <br>
1. Create the docker image <br>
  `docker build -t gcs-zip-file-server .` <br>
2. Run the docker image <br>
  `docker run -p 5000:5000 gcs-zip-file-server` <br>
NOTE: you'll need to set the container's environment variables based on the .env.example file, for example with `--env-file .env`


Running the app in development mode
-----------------------------------

0. Navigate to the `./eccc/file_server` path
  `cd eccc/file_server`
1. Create a python virtual environment
  `python -m venv env`
2. activate the environment
  `source env/bin/activate`
3. install the pip dependencies
  `pip install -r requirements.txt`
4. create the .env file with the needed values, based on the provided .env.example file
5. run the server
  `python -m swrs_api.app`


Running the unit tests
----------------------
`python -m pytest`

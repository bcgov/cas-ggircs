#!/bin/bash
set -e

__dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -z "$1" ]; then
    echo "Usage: $0 <bucket_name>"
    exit 0
fi

echo "download jq for test result assertions"
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq

node "$__dirname"/create-bucket --bucket="$1"
export DEPTH=2
export WEBSITE=https://nodejs.org/dist/
export FILTER='\.png|\.svg'

wget-spider >.list
cat .list

num_files=$(wc -l < .list)
"$__dirname"/../init.sh "$1" .list
outputFile="$__dirname"/../out/uploadOutput.json
echo "$outputFile"
cat "$outputFile"
num_files_uploaded=$(./jq '.uploadedObjects | length' "$outputFile")
echo "$num_files_uploaded"
"$__dirname"/../init.sh "$1" .list
echo "$outputFile"
cat "$outputFile"
num_files_skipped=$(./jq '.skippedUrls | length' "$outputFile")
echo "$num_files_skipped"
rm .list
rm "$outputFile"
node "$__dirname"/delete-bucket --bucket="$1"


if [ "$num_files" -ne "$num_files_uploaded" ]; then
    echo "failed"
    exit 1
fi
if [ "$num_files" -ne "$num_files_skipped" ]; then
    echo "failed"
    exit 1
fi
echo "passed"

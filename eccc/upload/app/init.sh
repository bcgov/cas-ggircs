#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <bucket_name> [<file_path>]"
    exit 0
fi

if [ ! -w . ]; then
    echo "User $(whoami) does not have write permissions"
    exit 1
fi

if [ -z "$2" ]; then
    FILE_URLS=$(wget-spider | awk '{printf "--url=\"%s\" ",$0}')
    echo "$FILE_URLS"
else
    cat "$2"
    FILE_URLS=$(awk '{printf "--url=\"%s\" ",$0}' < "$2")
fi

node upload --bucket="$1" $FILE_URLS

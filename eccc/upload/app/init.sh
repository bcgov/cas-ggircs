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
    declare -i RETRIES=0
    while [ $RETRIES -lt 20 ] && [ -z "$FILE_URLS" ]
    do
      FILE_URLS=$(wget-spider | awk '{printf "--url=\"%s\" ",$0}')
      if  [ -z "$FILE_URLS" ]; then
        RETRIES=$RETRIES+1
        echo 'wget failed to return any data. Retrying '$RETRIES'/20'
        sleep 2
      fi
    done

    if [ $RETRIES -eq 20 ]; then
      echo "Maximum number of retries exceeded. Failed to receive URL data."
      exit 1
    fi
    echo "$FILE_URLS"
else
    cat "$2"
    FILE_URLS=$(awk '{printf "--url=\"%s\" ",$0}' < "$2")
fi

node upload --bucket="$1" $FILE_URLS

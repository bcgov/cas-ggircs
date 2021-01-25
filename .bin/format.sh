#!/usr/bin/env bash

set -eo pipefail

pushd ggircs-app/app || exit 1
files=("$@")
files="${files[@]/#ggircs\-app\/app\//}" # remove "ggircs-app/app" from the file names

yarn run prettier --write $files
yarn run eslint --quiet --ext .js,.jsx,.ts,.tsx $files

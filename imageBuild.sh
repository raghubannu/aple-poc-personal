#!/bin/sh
set -xv
containerName=$1
version=$(grep -A1 war pom.xml | grep -v "war" | grep -o '<version>.*</version>' | sed 's/version//g' | sed 's/-SNAPSHOT//g' | sed 's/<//g' | sed 's/>//g'| sed 's+/++g')
docker build -t $containerName:$version -f Dockerfile .

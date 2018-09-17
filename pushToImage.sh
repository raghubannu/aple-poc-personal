#!/bin/sh
set -xv
containerName=$1
dockerUser=$2
dockerPassword=$3
version=$(grep -A1 war pom.xml | grep -v "war" | grep -o '<version>.*</version>' | sed 's/version//g' | sed 's/-SNAPSHOT//g' | sed 's/<//g' | sed 's/>//g'| sed 's+/++g')
docker login -u $dockerUser -p $dockerPassword
docker tag $containerName:$version $dockerUser/$containerName:$version
docker push $dockerUser/$containerName:$version

#!/bin/sh
set -xv
containerName=$1
version=$(grep -A1 war pom.xml | grep -v "war" | grep -o '<version>.*</version>' | sed 's/version//g' | sed 's/-SNAPSHOT//g' | sed 's/<//g' | sed 's/>//g'| sed 's+/++g')
docker run -id -p 9090:8080 $containerName:$version /bin/sh -c '/root/apache-tomcat-7.0.42-v2/bin/start.sh'

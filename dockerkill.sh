#!/bin/sh
set -xv
docker kill $(docker ps -a -q)
docker rm $(docker ps -a -q)


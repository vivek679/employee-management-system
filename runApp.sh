#!/usr/bin/env bash

#################### Basic variables ######################
PROJECT_ROOT=""
PROJECT_NAME=""
# shellcheck disable=SC2034
PROJECT_VERSION="v1"


# shellcheck disable=SC2034
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#################### Preparing environment specific values ######################
if [ -z "${PROJECT_ROOT}" ]; then
    PROJECT_ROOT=$(pwd)
fi
if [ -z "${PROJECT_NAME}" ]; then
    PROJECT_NAME=`cat pom.xml | grep finalName | sed "s@.*<finalName>\(.*\)</finalName>.*@\1@"`
fi

printf "\nPROJECT_ROOT :: (${GREEN}$PROJECT_ROOT${NC})"
printf "\nPROJECT_NAME :: (${GREEN}$PROJECT_NAME${NC}) (from pom.xml)"


## Inputs are done, starting building maven
echo ""
echo "Building app..."
echo "====================="
mvn clean install -DskipTests
if [ $? -ne 0 ]; then
        echo "Build failed. Exiting..."
        exit 1
fi

echo ""
#if docker images | grep employee-management-system; then
if docker images | grep "${PROJECT_NAME}"; then
	echo "Existing image found. Removing image..."
	docker rmi -f "${PROJECT_NAME}:${PROJECT_VERSION}" .
fi


## Get the current working directory
#cwd=$(pwd)
#echo "current working directory: ${cwd}"

# Now docker part---
cd ${PROJECT_ROOT}/docker
echo ""
echo "Building new image..."
echo "====================="
docker build --no-cache -t ${PROJECT_NAME}:${PROJECT_VERSION} .
#docker build --no-cache -t employee-management-system:v1 -f docker/Dockerfile .
#docker build --no-cache -t ${PROJECT_NAME}:${PROJECT_VERSION} -f /docker/Dockerfile.
if [ $? -eq 0 ]; then
	echo "... done"
else
	echo "... failed. Exiting..."
	exit 1
fi

echo ""
echo "====================="
if docker images | grep "${PROJECT_NAME}"; then
  echo "Existing image found."
fi
echo ""
echo "====================="


echo "Running container..."
echo "====================="
docker run -it --rm -p 9090:9090 ${PROJECT_NAME}:${PROJECT_VERSION}
if [ $? -eq 0 ]; then
	echo "... done"
else
	echo "... failed. Exiting..."
	exit 1
fi

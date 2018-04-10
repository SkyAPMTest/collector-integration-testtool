#!/usr/bin/env bash

BUILD_USER=$1

if [ -z "${BUILD_USER}" ]; then
    echo -e "\033[33mWARNING: BUILD_USER is empty,use default BUILD_USER(apache)!\033[0m"
    BUILD_USER="apache"
fi

echo "Building docker images..."
docker build -t skywalking --build-arg BUILD_USER="${BUILD_USER}" -f Dockerfile-skywalking .

echo "Starting docker compose..."
docker-compose up -d

echo "Success!"

#!/usr/bin/env bash

set -e

TEST_BRANCH=$1
IMAGE_PREFIX="skywalkingtest/collector-integration-testtool"

if [ -z "$TEST_BRANCH" ]; then
    echo -e "\033[33mWARNING: TEST_BRANCH is empty,use default branch(master)!\033[0m"
    TEST_BRANCH="master"
else
    echo -e "\033[32mCheckout: ${TEST_BRANCH}...\033[0m"
    git checkout ${TEST_BRANCH}
fi

echo -e "\033[32mBuild docker image...\033[0m"

docker build -t "${IMAGE_PREFIX}:${TEST_BRANCH}" .
docker-compose up -d

while :
do
    status_code=$(curl -m 5 -s -o /dev/null -w %{http_code} http://localhost:9200/?pretty)
    if [ ${status_code} -ne 200 ];then
        echo -e "\033[33mWaiting elasticsearch...\033[0m"
        sleep 1
    else
        echo -e "\033[32mElasticsearch connect is ok!\033[0m"
        break
    fi
done

echo -e "\033[32mStarting test!\033[0m"
docker run --rm -it "${IMAGE_PREFIX}:${TEST_BRANCH}"
echo -e "\033[32mDone!\033[0m"



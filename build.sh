#!/usr/bin/env bash

set -e

export BUILD_USER=${BUILD_USER:-"apache"}
export TEST_DATABASE=${TEST_DATABASE:-"es"}
export TEST_TIMEZONE=${TEST_TIMEZONE:-"UTC"}

while getopts "u:d:t:" OPT; do
    case $OPT in
        u)
            BUILD_USER=$OPTARG;;
        d)
            TEST_DATABASE=$OPTARG;;
        t)
            TEST_TIMEZONE=$OPTARG;;
    esac
done

if [ "${TEST_DATABASE}" != "es" ] && [ "${TEST_DATABASE}" != "h2" ]; then
    echo -e "\033[31mError: TEST_DATABASE type not supported,only es|h2 supported!\033[0m"
    exit 1
fi

echo -e "\033[32mTesting user ==> [${BUILD_USER}]\033[0m"
echo -e "\033[32mUsing database ==> [${TEST_DATABASE}]\033[0m"
echo -e "\033[32mUsing timezone ==> [${TEST_TIMEZONE}]\033[0m"

if [ "${TEST_TIMEZONE}" == "UTC" ]; then
    echo ""
    echo -e "\033[32mTips: If you want to change timezone,use '-t' option(e.g., -t 'Asia/Shanghai').\033[0m"
    echo -e "\033[32mSupported timezone reference: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones\033[0m"
    echo ""
    sleep 5
fi

echo "Building docker images..."
docker build -t skywalking  --build-arg BUILD_USER="${BUILD_USER}" \
                            --build-arg TEST_DATABASE="${TEST_DATABASE}" \
                            --build-arg TZ="${TZ}" \
                            -f Dockerfile-skywalking .

echo "Starting docker compose..."
docker-compose -f docker-compose-${TEST_DATABASE}.yaml up -d

echo "Success!"

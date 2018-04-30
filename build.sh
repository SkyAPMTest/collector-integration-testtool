# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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

if [ "${TEST_DATABASE}" != "es-rest" ] && [ "${TEST_DATABASE}" != "es-transport" ] && [ "${TEST_DATABASE}" != "h2" ]; then
    echo -e "\033[31mError: TEST_DATABASE type not supported,only es-rest|es-transport|h2 supported!\033[0m"
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

docker build -t skywalking-${TEST_DATABASE} --force-rm=true \
                                            --no-cache=true \
                                            -f  ./collector-storage-docker/${TEST_DATABASE}/Dockerfile-${TEST_DATABASE} .

echo "Starting docker compose..."
   docker-compose -f ./collector-storage-docker/${TEST_DATABASE}/docker-compose.yaml up -d
echo "Success!"

# build artifact
FROM maven:3.5.3-jdk-8-alpine as builder

COPY src /collector-integration-testtool/src
COPY pom.xml /collector-integration-testtool/pom.xml

WORKDIR /collector-integration-testtool

RUN mvn package

# build docker image
FROM openjdk:8u151-jdk-alpine3.7

# TZ default Asia/Shanghai,if you want modify TZ,
# use `docker build --build-arg TZ=xxx/xxx` to change it
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV PROJECT_NAME collector-integration-testtool

RUN apk upgrade --update \
    && apk add bash curl ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*

COPY --from=builder /${PROJECT_NAME}/target/${PROJECT_NAME}*jar /${PROJECT_NAME}.jar

CMD ["bash","-c","java -jar /${PROJECT_NAME}.jar"]

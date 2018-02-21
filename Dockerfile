FROM openjdk:8-jdk-alpine

ARG SBT_VERSION=1.1.1
ARG SBT_HOME=/usr/local/sbt

ENV SBT_VERSION=$SBT_VERSION
ENV SBT_HOME=$SBT_HOME

RUN apk add --no-cache bash \
    && apk add --no-cache --virtual app-deps-build \
           tar \
           wget \
    && echo "downloading sbt-$SBT_VERSION.tgz" \
    && wget https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O sbt-$SBT_VERSION.tgz -o /dev/null \
    && tar -xf sbt-$SBT_VERSION.tgz -C /usr/local \
    && echo -ne "- with sbt sbt-$SBT_VERSION\n" >> /root/.built \
    && rm sbt-$SBT_VERSION.tgz \
    # && sbt sbt-version \
    && apk del app-deps-build

VOLUME /app
WORKDIR /app

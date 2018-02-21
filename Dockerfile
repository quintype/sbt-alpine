FROM openjdk:8-jdk-alpine

LABEL maintainer="Quintype Devops <devops@quintype.com>"

ARG SBT_VERSION=1.1.1
ARG SBT_HOME=/usr/local/sbt

ENV SBT_VERSION=$SBT_VERSION
ENV SBT_HOME=$SBT_HOME
ENV PATH=$PATH:$SBT_HOME/bin

RUN apk add --no-cache bash \
    && apk add --no-cache --virtual app-deps-build \
           tar \
           wget \
    && echo "downloading sbt-$SBT_VERSION.tgz" \
    && wget https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O sbt-$SBT_VERSION.tgz -o /dev/null \
    && tar -xf sbt-$SBT_VERSION.tgz -C /usr/local \
    && echo -ne "- with sbt sbt-$SBT_VERSION\n" >> /root/.built \
    && mkdir -p /root/.ivy2/local \
    && cp -R $SBT_HOME/lib/local-preloaded/*.* /root/.ivy2/local \
    && rm sbt-$SBT_VERSION.tgz \
    && sbt sbtVersion \
    && apk del app-deps-build

VOLUME /root/.ivy2
VOLUME /app
WORKDIR /app

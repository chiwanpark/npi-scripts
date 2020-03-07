FROM arm64v8/debian:buster-slim
MAINTAINER Chiwan Park <chiwanpark@hotmail.com>

ARG JDK_VERSION
ARG ZULU_VERSION

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    JAVA_HOME=/opt/jdk \
    JDK_NAME=zulu${ZULU_VERSION}-ca-jdk${JDK_VERSION}-linux_aarch64

WORKDIR /tmp
RUN apt -y update && \
    apt -y install curl ca-certificates p11-kit locales && \
    locale-gen en_US.UTF-8 && \
    curl -L -O https://cdn.azul.com/zulu-embedded/bin/${JDK_NAME}.tar.gz && \
    tar -xzf ${JDK_NAME}.tar.gz -C /opt && \
    rm -rf /tmp/${JDK_NAME}.tar.gz && \
    mv /opt/${JDK_NAME} /opt/jdk && \
    apt clean && \
    apt autoclean && \
    ${JAVA_HOME}/bin/java -version

WORKDIR /opt/jdk

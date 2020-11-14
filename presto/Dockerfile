FROM bde2020/hadoop-base:latest

ENV PRESTO_VERSION=346
ENV PRESTO_HOME=/opt/presto
WORKDIR ${PRESTO_HOME}

#need java 11 (requires backports for stretch) and python for recent presto
RUN echo "deb http://deb.debian.org/debian stretch-backports main" >> /etc/apt/sources.list && \
    apt update && \
    apt install -y openjdk-11-jre python && \
    rm -rf /var/lib/apt/lists/*

RUN set -xe && curl -L https://repo1.maven.org/maven2/io/prestosql/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz | tar xz && \
    mv presto-server-${PRESTO_VERSION}/* . && \
    rmdir presto-server-${PRESTO_VERSION} && \
    mkdir -p ${PRESTO_HOME}/data

COPY etc ${PRESTO_HOME}/etc
VOLUME ["${PRESTO_HOME}/etc", "${PRESTO_HOME}/data"]
EXPOSE 8080

CMD ["bin/launcher", "run"]

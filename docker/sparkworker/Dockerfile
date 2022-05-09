FROM bde2020/spark-worker:3.2.0-hadoop3.2

RUN set -xe; \
    apk add --no-cache libc6-compat; \
    adduser -D -u 1000 local;

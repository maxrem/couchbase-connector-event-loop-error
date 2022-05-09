#!/bin/bash

USER=Administrator
PW=coffee
CLUSTER_RAM=1024
ITEM_RAM=512

set -e

echo Setup services
curl -sSf -u ${USER}:${PW} -XPOST http://couchbase:8091/node/controller/setupServices \
    -d services=kv,n1ql,index

echo Set memory quota
curl -sSf -u ${USER}:${PW} -XPOST http://couchbase:8091/pools/default \
    -d memoryQuota=${CLUSTER_RAM}

echo Set username and password
curl -sSf -u ${USER}:${PW} -XPOST http://couchbase:8091/settings/web \
    -d username=${USER} \
    -d password=${PW} \
    -d port=8091

echo Create item bucket
curl -sSf -u ${USER}:${PW} -XPOST http://couchbase:8091/pools/default/buckets \
    -d flushEnabled=1 \
    -d replicaIndex=0 \
    -d replicaNumber=0 \
    -d ramQuotaMB=${ITEM_RAM} \
    -d bucketType=couchbase \
    -d authType=none \
    -d name=item

echo DONE!

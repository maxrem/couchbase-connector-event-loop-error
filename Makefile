all: docker-up

init: docker-up wait-couchbase init-couchbase

.PHONY: all init docker-up wait-couchbase init-couchbase

docker-up:
	docker-compose up -d --remove-orphans --build

wait-couchbase:
	@while ! docker-compose exec spark-worker nc -z couchbase 8091; do echo "Waiting for couchbase"; sleep 1; done; sleep 1;

init-couchbase:
	docker-compose exec -T couchbase bash /opt/configure-couchbase/init.sh

run:
	sbt assembly
	docker-compose exec --user local spark-worker /spark/bin/spark-submit --class CouchbaseUpsert /opt/target/scala-2.12/couchbase-upsert-assembly-0.0.1.jar

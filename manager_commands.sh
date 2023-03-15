#! /bin/bash

docker node update --label-add replica=1 minio1
docker node update --label-add replica=2 minio2
docker node update --label-add replica=3 minio3
docker node update --label-add replica=4 minio4

docker stack deploy -c docker-stack.yml minio

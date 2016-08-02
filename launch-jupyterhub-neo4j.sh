#!/bin/bash
docker stop jupyterhub neo4j
docker rm jupyterhub neo4j
#
docker run -itd \
-v $(pwd)/data:/data \
-p 0.0.0.0:7474:7474 \
-p 0.0.0.0:7473:7473 \
-p 0.0.0.0:7687:7687 \
-p 0.0.0.0:1337:1337 \
--env=NEO4J_AUTH=none \
--name neo4j \
hermantolentino/docker-alpine-neo4j:v1
#
docker run -itd \
-v $(pwd):/home/jupyterhub/hostdir \
-p 0.0.0.0:8000:8000 \
-p 0.0.0.0:8080:8080 \
--name jupyterhub \
--link neo4j:neo4j \
hermantolentino/jupyterhub-packages:v1 \
supervisord -c /etc/supervisord.conf

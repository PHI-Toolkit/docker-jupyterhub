#!/bin/bash
# "jupyterhub" referred to below assumes this as the container name when the container is launched
#   with launch-neo4j.sh
docker stop jupyterhub
docker rm jupyterhub
docker build -t hermantolentino/docker-jupyterhub:v5 .
docker build -t hermantolentino/jupyterhub-packages:v1 -f Dockerfile-packages .
docker build -t hermantolentino/docker-otb:v1 -f Dockerfile-otb-apt .

#!/bin/bash
docker stop jupyterhub
docker rm jupyterhub
docker run -itd \
-v $(pwd):/home/jupyterhub/hostdir \
-p 0.0.0.0:8000:8000 \
-p 0.0.0.0:8080:8080 \
--name jupyterhub \
hermantolentino/docker-deeplearning:v1 \
supervisord -c /etc/supervisord.conf

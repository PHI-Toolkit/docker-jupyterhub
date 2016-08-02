#!/bin/bash
docker run -itd \
-v $(pwd):/home/jupyterhub/hostdir \
-p 0.0.0.0:8000:8000 \
-p 0.0.0.0:8080:8080 \
--name jupyterhub \
hermantolentino/jupyterhub-packages:v1 \
supervisord -c /etc/supervisord.conf

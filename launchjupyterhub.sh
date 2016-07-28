docker run -v $(pwd):/home/jupyterhub/hostdir -itd \
-p 0.0.0.0:8000:8000 \
-p 0.0.0.0:8080:8080 \
--name jupyterhub \
--link neo4j:neo4j \
hermantolentino/jupyterhub-packages:v1 \
supervisord -c /etc/supervisord.conf

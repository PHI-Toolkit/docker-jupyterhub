#!/bin/bash
# comment
bash nbextensions/loadnbextensions.sh
jupyterhub --port 8000 --ssl-key /etc/ssl/certs/server.key --ssl-cert /etc/ssl/certs/server.crt

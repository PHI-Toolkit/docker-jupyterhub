#!/bin/bash
source /venv27/bin/activate
pip2 install py2neo
pip2 install psycopg2
pip2 install mysqlclient
pip3 install redis
deactivate

source /venv35/bin/activate
pip3 install py2neo
pip3 install psycopg2
pip3 install mysqlclient
pip3 install redis
deactivate

#!/bin/bash

source /venv27/bin/activate
pip2 install cycli py2neo neo4j-driver neo4jrestclient==2.0.0
pip2 install psycopg2
pip2 install mysqlclient
pip2 install redis
pip2 install pymongo
pip2 install pyArango python-arango
deactivate

source /venv35/bin/activate
pip3 install cycli py2neo neo4j-driver neo4jrestclient==2.0.0
pip3 install psycopg2
pip3 install mysqlclient
pip3 install redis
pip3 install pymongo
pip3 install pyArango python-arango
deactivate

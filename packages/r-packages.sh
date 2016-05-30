#!/bin/bash
apt-get install -y libysqlclient-dev unixodbc unixodbc-dev libxml2-dev libglu1-mesa-dev libgsl0-dev
Rscript $(pwd)/packages/essential-packages.R

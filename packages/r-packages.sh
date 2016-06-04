#!/bin/bash
apt-get update
apt-get install -y libmysqlclient* unixodbc unixodbc-dev \
  libxml2-dev libglu1-mesa-dev libgsl0ldbl libgsl0-dev libx11-dev mesa-common-dev libglu1-mesa-dev
Rscript /home/$NB_USER/packages/essential-packages.R

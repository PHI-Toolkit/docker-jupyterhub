#!/bin/bash
apt-get update
apt-get install -y libmysqlclient* unixodbc unixodbc-dev \
  libxml2-dev libglu1-mesa-dev libgsl0ldbl libgsl0-dev libx11-dev mesa-common-dev libglu1-mesa-dev libssh2-1-dev \
  libcairo2-dev libxt-dev
Rscript /home/$NB_USER/packages/essential-packages.R

apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*

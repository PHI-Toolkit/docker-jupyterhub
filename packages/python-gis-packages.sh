#!/bin/bash

# Reference for installing GDAL:
# http://gis.stackexchange.com/questions/28966/python-gdal-package-missing-header-file-when-installing-via-pip

# Use UbuntuGIS repository for GDAL
apt-get install -y software-properties-common
apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable
apt-get update
apt-get install -y libcpl-dev libgeos-dev libgdal-dev libgdal1i libgdal1-dev libproj-dev \
    libgeos-dev gdal-bin
apt-get install -y python-gdal

# important step for installing GDAL
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

# GDAL pip install exception
source /venv27/bin/activate
pip install ipyparallel
pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
#pip install GDAL
pip install geojson cartopy pyshp
pip install scikit-image pysal geopandas
deactivate

# GDAL pip install exception
source /venv35/bin/activate
pip3 install ipyparallel
pip3 install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
#pip3 install GDAL
pip3 install geojson cartopy pyshp
pip3 install scikit-image pysal geopandas
deactivate

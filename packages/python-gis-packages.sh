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
apt-get install python-mpltoolkists.basemap python3-mpltoolkits.basemap

# important step for installing GDAL
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

# GDAL pip install exception
source /vepypy/bin/activate
pip install --upgrade setuptools pip
pip install ipyparallel
#pip install GDAL
pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
# https://github.com/EverythingMe/geodis
pip install geojson cartopy pyshp geopy pygeocodio
pip install scikit-image pysal geopandas
pip install Geobases
pip install -i https://pypi.anaconda.org/pypi/simple geocoder
# https://github.com/thampiman/reverse-geocoder
pip install reverse_geocoder
deactivate

source /venv27/bin/activate
pip install --upgrade setuptools pip
pip install ipyparallel
#pip install GDAL
pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
# https://github.com/EverythingMe/geodis
pip install geojson cartopy pyshp geopy pygeocodio
pip install scikit-image pysal geopandas
pip install Geobases
pip install -i https://pypi.anaconda.org/pypi/simple geocoder
# https://github.com/thampiman/reverse-geocoder
pip install reverse_geocoder
deactivate

# GDAL pip install exception
source /venv35/bin/activate
pip3 install --upgrade setuptools pip
pip3 install ipyparallel
#pip3 install GDAL
pip3 install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
# https://github.com/EverythingMe/geodis
pip3 install geojson cartopy pyshp geopy pygeocodio
pip3 install scikit-image pysal geopandas
pip3 install Geobases3K
pip3 install -i https://pypi.anaconda.org/pypi/simple geocoder
# https://github.com/thampiman/reverse-geocoder
pip3 install reverse_geocoder
deactivate

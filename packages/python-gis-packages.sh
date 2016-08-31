#!/bin/bash

# Reference for installing GDAL:
# http://gis.stackexchange.com/questions/28966/python-gdal-package-missing-header-file-when-installing-via-pip

# Use UbuntuGIS repository for GDAL
apt-get install -y software-properties-common
apt-add-repository -y ppa:ubuntugis/ubuntugis-unstable
apt-get update
#apt-get install -y libcpl-dev libgeos-dev libgdal-dev libgdal1h libgdal1-dev libproj-dev \
#    libgeos-dev gdal-bin
apt-get install -y libcpl-dev libgeos-dev libgdal-dev libgdal1-dev libproj-dev \
    libgeos-dev gdal-bin
apt-get install -y python-gdal libgeos-c1
apt-get install -y libffi-dev libssl-dev
apt-get install -yf
#apt-get install python-mpltoolkists.basemap python3-mpltoolkits.basemap
wget http://mirrors.kernel.org/ubuntu/pool/universe/b/basemap/python-mpltoolkits.basemap_1.0.7+dfsg-1_amd64.deb
dpkg -i python-mpltoolkits.basemap_1.0.7+dfsg-1_amd64.deb
apt-get install -yf
rm *.deb

# important step for installing GDAL
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

source /venv27/bin/activate
pip2 install --upgrade setuptools pip
pip2 install --upgrade ipyparallel
pip2 install --upgrade pyopenssl ndg-httpsclient pyasn1
#pip install GDAL
pip2 install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
# https://github.com/EverythingMe/geodis
pip2 install geojson pyshp geopy pygeocodio
pip2 install scikit-image pysal geopandas
pip2 install Geobases
pip2 install -i https://pypi.anaconda.org/pypi/simple geocoder
# https://github.com/thampiman/reverse-geocoder
pip2 install reverse_geocoder
deactivate

# GDAL pip install exception
source /venv35/bin/activate
pip3 install --upgrade setuptools pip
pip3 install --upgrade ipyparallel
pip3 install --upgrade pyopenssl ndg-httpsclient pyasn1
#pip3 install GDAL
pip3 install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
# https://github.com/EverythingMe/geodis
pip3 install geojson pyshp geopy pygeocodio
pip3 install scikit-image pysal geopandas
pip3 install Geobases3K
pip3 install -i https://pypi.anaconda.org/pypi/simple geocoder
# https://github.com/thampiman/reverse-geocoder
pip3 install reverse_geocoder
deactivate

apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*

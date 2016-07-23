#!/bin/bash
# https://github.com/rasbt/pattern_classification/blob/master/resources/python_data_libraries.md
apt-get update
apt-get install -y libhdf5-serial-dev libfreetype6-dev
apt-get install -y libffi-dev libssl-dev

source /venv27/bin/activate
pip2 install pyasn 
pip2 install retry
pip2 install numpy pandas
pip2 install joblib cython xgboost python-dateutil
pip2 install scipy scikit-learn crab sklearn-pandas
pip2 install h5py
pip2 install statsmodels pybrain gensim
pip2 install bokeh plotly vega folium vincent
pip2 install matplotlib
pip2 install csvkit tables Dora
pip2 install ipywidgets
pip2 install seaborn lightning-python
pip2 install blaze
pip2 install ipython-cypher
pip2 install yhat
deactivate

source /venv35/bin/activate
pip3 install --upgrade setuptools pip
deactivate

source /venv35/bin/activate
pip3 install retry
pip3 install numpy pandas
pip3 install joblib cython xgboost python-dateutil
pip3 install scipy scikit-learn crab sklearn-pandas
pip3 install h5py
pip3 install statsmodels pybrain gensim
pip3 install bokeh plotly vega folium vincent
pip3 install matplotlib
pip3 install csvkit tables
pip3 install ipywidgets
pip3 install seaborn
pip3 install blaze lightning-python
pip3 install ipython-cypher
# nonstandard installs
# install poster for Python 3.4
git clone https://github.com/mrd1no/poster-0.8.1-for-Python-3.4.git
cd poster-0.8.1-for-Python-3.4
python3 setup.py install
cd ..
pip3 install yhat
deactivate

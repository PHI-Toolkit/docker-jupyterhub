#!/bin/bash
# https://github.com/rasbt/pattern_classification/blob/master/resources/python_data_libraries.md
apt-get update
apt-get install -y libhdf5-serial-dev libfreetype6-dev

source /vepypy/bin/activate
pip install --upgrade setuptools pip
pip install retry
pip install git+https://bitbucket.org/pypy/numpy.git
pip install pandas
pip install joblib cython xgboost python-dateutil
pip install scipy scikit-learn crab sklearn-pandas
pip install h5py
pip install statsmodels pybrain gensim
pip install bokeh plotly vega folium vincent
pip install matplotlib
pip install csvkit tables Dora
pip install ipywidgets
pip install seaborn lightning-python
pip install blaze
pip install ipython-cypher
pip install yhat
deactivate

source /venv27/bin/activate
pip install --upgrade setuptools pip
pip install retry
pip install numpy pandas
pip install joblib cython xgboost python-dateutil
pip install scipy scikit-learn crab sklearn-pandas
pip install h5py
pip install statsmodels pybrain gensim
pip install bokeh plotly vega folium vincent
pip install matplotlib
pip install csvkit tables Dora
pip install ipywidgets
pip install seaborn lightning-python
pip install blaze
pip install ipython-cypher
pip install yhat
deactivate

source /venv35/bin/activate
pip3 install --upgrade setuptools pip
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

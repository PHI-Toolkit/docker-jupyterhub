#!/bin/bash
# https://github.com/rasbt/pattern_classification/blob/master/resources/python_data_libraries.md
apt-get update
apt-get install -y libhdf5-serial-dev libfreetype6-dev

source /venv27/bin/activate
pip install numpy pandas
pip install scipy scikit-learn h5py
pip install statsmodels pybrain gensim
pip install bokeh plotly vega folium vincent
pip install matplotlib
pip install csvkit tables
pip install ipywidgets
pip install nltk seaborn
pip install blaze
pip install beautifulsoup4
pip install ipython-cypher
deactivate

source /venv35/bin/activate
pip3 install numpy pandas
pip3 install scipy scikit-learn h5py
pip3 install statsmodels pybrain gensim
pip3 install bokeh plotly vega folium vincent
pip3 install matplotlib 
pip3 install csvkit tables
pip3 install ipywidgets
pip3 install nltk seaborn
pip3 install blaze
pip3 install beautifulsoup4
pip3 install ipython-cypher
deactivate

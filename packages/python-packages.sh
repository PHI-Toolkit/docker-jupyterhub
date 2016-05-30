#!/bin/bash
# https://github.com/rasbt/pattern_classification/blob/master/resources/python_data_libraries.md
apt-get install -y libhdf5-serial-dev libfreetype6-dev

source /venv27/bin/activate
pip install numpy pandas scipy scikit-learn h5py
pip install statsmodels pybrain && \
pip install bokeh plotly
pip install matplotlib
pip install csvkit tables
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension
pip install -U nltk auxlib conda
deactivate

source /venv35/bin/activate
pip3 install numpy pandas scipy scikit-learn h5py
pip3 install statsmodels pybrain
pip3 install bokeh plotly
pip3 install matplotlib
pip3 install csvkit tables
pip3 install ipywidgets
jupyter nbextension enable --py widgetsnbextension
pip3 install -U nltk auxlib conda
deactivate

# download nltk data to /usr/share/nltk
python packages/download-nltk-data.py

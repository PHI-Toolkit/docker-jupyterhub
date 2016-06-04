#!/bin/bash

source /venv27/bin/activate
pip install fileupload ipyleaflet
pip install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py ipyleaflet
jupyter nbextension install --py vega
jupyter nbextension enable --py vega
jupyter nbextension install --py fileupload
jupyter nbextension enable --py fileupload
deactivate

source /venv35/bin/activate
pip3 install fileupload ipyleaflet
pip3 install https://github.com/ipython-contrib/IPython-notebook-extensions/archive/master.zip
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py ipyleaflet
jupyter nbextension install --py vega
jupyter nbextension enable --py vega
jupyter nbextension install --py fileupload
jupyter nbextension enable --py fileupload
deactivate

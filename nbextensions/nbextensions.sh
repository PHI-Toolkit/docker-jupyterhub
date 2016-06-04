#!/bin/bash
# comment
source /venv27/bin/activate
jupyter nbextension install --py vega
jupyter nbextension enable --py --sys-prefix vega
jupyter nbextension enable --py ipyleaflet
jupyter nbextension install --py fileupload
jupyter nbextension enable --py fileupload
deactivate

source /venv35/bin/activate
jupyter nbextension install --py vega
jupyter nbextension enable --py --sys-prefix vega
jupyter nbextension enable --py ipyleaflet
jupyter nbextension install --py fileupload
jupyter nbextension enable --py fileupload
deactivate

jupyter nbextension enable --py --sys-prefix widgetsnbextension

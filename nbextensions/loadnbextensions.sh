#!/bin/bash
source /vepypy/bin/activate
jupyter nbextension enable scpy3/style
jupyter nbextension enable scpy3/macro
jupyter nbextension enable scpy3/copycells
jupyter nbextension enable scpy3/slice
jupyter nbextension enable scpy3/iconbox
jupyter nbextension enable scpy3/maximize
jupyter nbextension enable scpy3/toc
jupyter nbextension enable scpy3/run_mdcell
jupyter nbextension enable scpy3/bookmark
jupyter nbextension enable scpy3/slide
deactivate

source /venv27/bin/activate
jupyter nbextension enable scpy3/style
jupyter nbextension enable scpy3/macro
jupyter nbextension enable scpy3/copycells
jupyter nbextension enable scpy3/slice
jupyter nbextension enable scpy3/iconbox
jupyter nbextension enable scpy3/maximize
jupyter nbextension enable scpy3/toc
jupyter nbextension enable scpy3/run_mdcell
jupyter nbextension enable scpy3/bookmark
jupyter nbextension enable scpy3/slide
deactivate

source /venv35/bin/activate
jupyter nbextension enable scpy3/style
jupyter nbextension enable scpy3/macro
jupyter nbextension enable scpy3/copycells
jupyter nbextension enable scpy3/slice
jupyter nbextension enable scpy3/iconbox
jupyter nbextension enable scpy3/maximize
jupyter nbextension enable scpy3/toc
jupyter nbextension enable scpy3/run_mdcell
jupyter nbextension enable scpy3/bookmark
jupyter nbextension enable scpy3/slide
deactivate

source /vepypy/bin/activate
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py ipyleaflet
jupyter nbextension enable --py vega
jupyter nbextension enable --py fileupload
deactivate

source /venv27/bin/activate
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py ipyleaflet
jupyter nbextension enable --py vega
jupyter nbextension enable --py fileupload
deactivate

source /venv35/bin/activate
jupyter nbextension enable --py widgetsnbextension
jupyter nbextension enable --py ipyleaflet
jupyter nbextension enable --py vega
jupyter nbextension enable --py fileupload
deactivate

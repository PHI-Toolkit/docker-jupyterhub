#!/bin/bash
$(pwd)/packages/python-packages.sh
$(pwd)/packages/r-packages.sh

# download nltk data to /usr/share/nltk
$(pwd)/packages/download_nltk-data.sh

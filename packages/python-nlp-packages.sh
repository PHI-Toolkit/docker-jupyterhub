#!/bin/bash
apt-get update
apt-get install -y portaudio19-dev flac uchardet libmagic1 enca recode python-lxml \
  libxml2-dev libxslt-dev

source /venv27/bin/activate
pip install --upgrade setuptools pip
pip install cchardet, pyicu, cssutils, chardet, shutilwhich, python-magic
pip install nltk
pip install beautifulsoup4
pip install spacy
#python -m spacy.en.download
pip install SpeechRecognition
pip install PyAudio
pip install pattern, justext
pip install pyquery httplib2 biopython
deactivate

source /venv35/bin/activate
pip3 install --upgrade setuptools pip
pip3 install cchardet, pyicu, cssutils, chardet, shutilwhich, python-magic
pip3 install nltk
pip3 install beautifulsoup4
pip3 install spacy
#python -m spacy.en.download
pip3 install SpeechRecognition
pip3 install PyAudio
# pattern uses pip2 due to print() error
# pip3 install pattern, justext
pip3 install pyquery httplib2 biopython
deactivate

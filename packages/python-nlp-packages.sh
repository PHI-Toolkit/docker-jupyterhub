#!/bin/bash
apt-get update
apt-get install -y portaudio19-dev flac uchardet libmagic1 enca recode python-lxml \
  libxml2-dev libxslt-dev ed

source /venv27/bin/activate
pip2 install --upgrade setuptools pip
pip2 install chardet
pip2 install pyicu
pip2 install cssutils
pip2 install shutilwhich
pip2 install python-magic
pip2 install nltk
pip2 install beautifulsoup4
pip2 install spacy
#python -m spacy.en.download
pip2 install SpeechRecognition
pip2 install PyAudio
pip2 install justext
pip2 install pyquery httplib2 biopython
pip2 install newspaper
pip2 install service_identity scrapy
deactivate

source /venv35/bin/activate
pip3 install --upgrade setuptools pip
pip3 install chardet
pip3 install pyicu
pip3 install cssutils
pip3 install shutilwhich
pip3 install python-magic
pip3 install nltk
pip3 install beautifulsoup4
pip3 install spacy
#python -m spacy.en.download
pip3 install SpeechRecognition
pip3 install PyAudio
# pattern uses pip2 due to print() error
# pip3 install pattern, justext
pip3 install pyquery httplib2 biopython
pip3 install newspaper3k
pip3 install service_identity scrapy
deactivate

# installing nltk and data below as a unit
echo "deb http://us.archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list
apt-get update
apt-get install -y python-numpy python-nltk

apt-get clean
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*

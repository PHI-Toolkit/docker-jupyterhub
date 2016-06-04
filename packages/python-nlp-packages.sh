#!/bin/bash
apt-get update
apt-get install -y portaudio19-dev flac

source /venv27/bin/activate
pip install nltk
pip install beautifulsoup4
pip install spacy
#python -m spacy.en.download
pip install SpeechRecognition
pip install PyAudio
deactivate

source /venv35/bin/activate
pip3 install nltk
pip3 install beautifulsoup4
pip3 install spacy
#python -m spacy.en.download
pip3 install SpeechRecognition
pip3 install PyAudio
deactivate

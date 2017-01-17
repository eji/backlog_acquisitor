FROM debian:latest

RUN apt-get update \
  && apt-get install -y build-essential libssl-dev libffi-dev python-dev python-pip libsasl2-dev libldap2-dev \
  && echo '1' \
  && pip install virtualenv \
  && echo '2' \
  && virtualenv venv \
  && echo '3' \
  && . ./venv/bin/activate \
  && echo '4' \
  && pip install --upgrade setuptools pip \
  && echo '5' \
  && pip install superset \
  && echo '6' \
  && fabmanager create-admin --app superset \
  && echo '7' \
  && superset db upgrade \
  && echo '8' \
  && superset load_examples \
  && echo '9' \
  && superset init \
  && echo '10' \
  && apt-get remove --purge -y build-essential \
  && echo '11' \
  && rm -rf /var/lib/apt/lists/*

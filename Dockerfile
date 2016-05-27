FROM ubuntu:14.04

MAINTAINER herman.tolentino@gmail.com

USER root

# Install all OS dependencies for fully functional notebook server
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git nano wget \
    build-essential python-dev \
    ca-certificates \
    bzip2 unzip \
    libsm6 \
    texlive-latex-base texlive-latex-extra \
    texlive-fonts-extra texlive-fonts-recommended \
    texlive-generic-recommended \
    sudo \
    locales \
    libxrender1 \
    ca-certificates \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN apt-get update
RUN apt-get install -y language-pack-en-base
RUN dpkg-reconfigure locales

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER jupyter
ENV NB_UID 1000
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# This is important later for installing R and R packages
RUN mkdir -p /etc/pki/tls/certs/ && \
    ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

# Download Anaconda and place it in the same directory as this Dockerfile
COPY Anaconda3-4.0.0-Linux-x86_64.sh /tmp/
RUN cd /tmp && \
    /bin/bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p /opt/conda && \
    $CONDA_DIR/bin/conda install --quiet --yes conda && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    conda clean -tipsy

RUN apt-get update -y
RUN apt-get install -y python-dev python3-dev npm python-pip python3-pip nodejs-legacy

# Generate self-signed certificate
RUN openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
    openssl rsa -passin pass:x -in server.pass.key -out server.key && \
    rm server.pass.key
RUN openssl req -new -key server.key -out server.csr \
    -subj "/C=US/ST=GA/L=Atlanta/O=OrgName/OU=IT Department/CN=example.com" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
RUN cp server.crt /etc/ssl/certs/ && \
    cp server.key /etc/ssl/certs/

RUN conda install --quiet --yes \
#    'notebook=4.2*' \
    terminado \
    && conda clean -tipsy

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0527A9B7 && \
    gpg --verify /tini.asc
RUN chmod +x /tini

# Install JupyterHub: https://github.com/jupyterhub/jupyterhub
# JupyterHub is a multi-user server for Jupyter

# configure virtual environments
RUN ln -snf /bin/bash /bin/sh
RUN pip install virtualenv && \
    pip3 install virtualenv

RUN virtualenv -p /usr/bin/python2 venv27 && \
    source venv27/bin/activate && \
    pip install notebook ipykernel requests && \
    ipython kernelspec install-self && \
    deactivate

RUN virtualenv -p /usr/bin/python3 venv35 && \
    source venv35/bin/activate && \
    pip3 install notebook ipykernel requests && \
    ipython3 kernelspec install-self && \
    deactivate

RUN conda install --yes anaconda
RUN npm install -g configurable-http-proxy && \
    pip3 install jupyterhub && \
    pip3 install jupyter && \
    mkdir -p /etc/jupyterhub && \
    mkdir -p /root/work
COPY jupyterhub_config.py /etc/jupyterhub
COPY startjupyterhub.sh /root/work

RUN mkdir -p /var/log/jupyterhub
RUN touch /var/log/jupyterhub/jupyterhub.log
RUN echo "PATH=/opt/conda/bin:/opt/conda:$PATH" >> /etc/environment

# This is a default user you can use to log in to JupyterHub
# You can create your own account by entering the bash shell and creating your own user account or
#   change "jupyterhub" and "Password1" below.
RUN adduser --gecos "" jupyterhub && \
    echo jupyterhub:Password1 | chpasswd

# Expose ports
EXPOSE 8888
EXPOSE 8956
EXPOSE 8957
EXPOSE 8081
EXPOSE 8000

WORKDIR /root/work

ENTRYPOINT ["/tini", "--"]

CMD ["/bin/bash"]

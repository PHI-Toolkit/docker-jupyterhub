# Install JupyterHub: https://github.com/jupyterhub/jupyterhub
# JupyterHub is a multi-user server for Jupyter
# This installation does not use Anaconda.

FROM ubuntu:14.04

MAINTAINER herman.tolentino@gmail.com

USER root

# Install all OS dependencies for fully functional notebook server
# Based on https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    git nano wget \
    build-essential ca-certificates \
    bzip2 unzip \
    libsm6 \
    sudo locales \
    locate \
    libxrender1 default-jdk \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure environment
ENV SHELL /bin/bash
ENV NB_USER jupyterhub
ENV NB_UID 1000
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN echo "$LANGUAGE UTF-8" > /etc/locale.gen && \
    locale-gen
RUN apt-get update
RUN apt-get install -y language-pack-en-base
RUN dpkg-reconfigure locales

# This is a default user you can use to log in to JupyterHub
#   login: jupyterhub
#   password: Password1
# You can create your own account by entering the bash shell and creating your own user account or
#   change "jupyterhub" and "Password1" below.
RUN useradd -m -s $SHELL -N -u $NB_UID $NB_USER && \
    echo jupyterhub:Password1 | chpasswd
RUN echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

RUN mkdir -p /root/work && \
    mkdir -p /root/work/.backup
RUN echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /root/.curlrc
RUN echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /root/work/.curlrc

# This certificate link is important later for installing R and R packages
RUN mkdir -p /etc/pki/tls/certs/ && \
    ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

# Generate self-signed certificate
RUN openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
    openssl rsa -passin pass:x -in server.pass.key -out server.key && \
    rm server.pass.key
RUN openssl req -new -key server.key -out server.csr \
    -subj "/C=US/ST=GA/L=Atlanta/O=OrgName/OU=IT Department/CN=example.com" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
RUN cp server.crt /etc/ssl/certs/ && \
    cp server.key /etc/ssl/certs/

# Add Tini
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0527A9B7 && \
    gpg --verify /tini.asc
RUN chmod +x /tini

RUN apt-get update
RUN apt-get install -y python-dev python3-dev npm python-pip python3-pip nodejs-legacy python-virtualenv pypy
RUN apt-get install -y libzmq3 libzmq3-dev python3-zmq
RUN apt-get install -y libffi-dev libssl-dev

# use bash
RUN ln -snf /bin/bash /bin/sh

# configure Python virtual environments
RUN \
    virtualenv --system-site-packages -p /usr/bin/python2 /venv27 && \
    source /venv27/bin/activate && \
    wget bootstrap.pypa.io/ez_setup.py -O - | python && \
    pip2 install --upgrade pip setuptools tornado jupyter ipykernel requests terminado jupyter_contrib_core && \
    ipython kernel install --name python2 --display-name "Python 2.7" && \
    deactivate

RUN virtualenv --system-site-packages -p /usr/bin/python3 /venv35 && \
    source /venv35/bin/activate && \
    wget bootstrap.pypa.io/ez_setup.py -O - | python3 && \
    pip3 install --upgrade setuptools tornado jupyter ipykernel requests terminado jupyter_contrib_core && \
    ipython kernel install --name python3 --display-name "Python 3.5" && \
    deactivate

RUN virtualenv --system-site-packages -p /usr/bin/pypy /vepypy && \
    source /vepypy/bin/activate && \
    wget bootstrap.pypa.io/ez_setup.py -O - | python && \
    pip install --upgrade pip setuptools tornado jupyter ipykernel requests && \
    pip install --upgrade pyzmq terminado && \
    pip install --upgrade jupyter_contrib_core && \
    ipython kernel install --name vepypy --display-name "Python-PyPy 2.7" && \
    deactivate

RUN npm install -g configurable-http-proxy && \
    pip3 install jupyterhub && \
    pip3 install jupyter jupyter_core jupyter_contrib_core && \
    mkdir -p /etc/jupyterhub && \
    mkdir -p /root/work
COPY etc/jupyterhub_config.py /etc/jupyterhub/
COPY startjupyterhub.sh /root/work
COPY stopjupyterhub.sh /root/work

RUN mkdir -p /var/log/jupyterhub
RUN touch /var/log/jupyterhub/jupyterhub.log

# Install Bash shell
# http://datascienceatthecommandline.com/#tools
RUN pip2 install bash_kernel && \
  pip3 install bash_kernel && \
  python3 -m bash_kernel.install
RUN pip3 install awscli bigmler csvkit
RUN apt-get update && \
  apt-get install -y cowsay mawk bc feedgnuplot findutils less parallel tree curl && \
  echo "export PATH=$PATH:/usr/games" >> /etc/profile && \
  echo "export PATH=$PATH:/usr/games" >> /home/jupyterhub/.bashrc
RUN npm install xml2json-command

# Install Scala 2.11
# Based on https://github.com/alexarchambault/jupyter-scala
# Initial launch in notebook takes a while due to launcher downloading additional libraries
# util.Properties.versionString
RUN curl -L -o jupyter-scala https://git.io/vrHhi && \
    chmod +x jupyter-scala && \
    ./jupyter-scala && \
    rm -f jupyter-scala
RUN /root/.local/share/jupyter/kernels/scala211/launcher.jar --global --quiet

# Install IRuby and SciRuby 2.1.5
# Based on https://github.com/SciRuby/sciruby and http://sciruby.com/docs/
# and https://www.brightbox.com/docs/ruby/ubuntu/

# Install latest Ruby, Ruby Version Manager
RUN apt-get install -y python-apt python-pycurl software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng --yes && \
    apt-get update
RUN apt-get install -y ruby2.2 ruby2.2-dev libtool libmagickwand-dev imagemagick bundler gnuplot \
    libgsl0-dev zlib1g-dev libatlas-base-dev
RUN apt-get install -y libblas-dev checkinstall && \
    apt-get install -y liblapacke-dev checkinstall autoconf automake
RUN gem install erector bundler gnuplot
RUN gem install sciruby-full
# iruby register creates the kernel.json and kernelspec install makes it visible to jupyter
RUN iruby register --force && \
    ipython kernelspec install /root/.ipython/kernels/ruby

## Install R
RUN mkdir -p /usr/local/lib/R/site-library && \
    chmod -R a+w /usr/local/lib/R/site-library

RUN echo 'deb http://cran.rstudio.com/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list && \
    echo "options(repos = c(CRAN = 'http://cran.us.r-project.org'))" > /etc/Rprofile.site

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update -y && \
    apt-get install -y r-base r-base-dev r-base-core

RUN apt-get update && \
    apt-get -y build-dep libcurl4-gnutls-dev && \
    apt-get -y install libcurl4-gnutls-dev libzmq3-dev r-cran-rjava r-cran-rodbc swig sqlite3 libssh2-1-dev

RUN R -e "install.packages('RCurl', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('curl', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('httr', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('devtools', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('repr', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('base64enc', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('evaluate', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('uuid', lib='/usr/local/lib/R/site-library', repos='http://cran.rstudio.com/')" && \
    R -e "install.packages('rzmq', repos = 'http://irkernel.github.io/', type = 'source')"
RUN R -e "install.packages(c('IRkernel','IRdisplay'), repos = 'http://irkernel.github.io/', type = 'source')" && \
    R -e "IRkernel::installspec(user=FALSE)"

RUN apt-get install -y libyaml-dev pypy-dev

# Backup local files to container image
COPY etc/ /root/work/.backup/
COPY etc/ /etc/
RUN mkdir -p /root/work/.backup/nbextensions
COPY nbextensions/ /root/work/.backup/nbextensions/
RUN mkdir -p /root/work/.backup/packages
COPY packages/ /root/work/.backup/packages/
RUN mkdir -p /root/work/.backup/notebooks
COPY notebooks/ /root/work/.backup/notebooks/
RUN mkdir -p /home/$NB_USER/packages
RUN mkdir -p /home/$NB_USER/notebooks
RUN mkdir -p /home/$NB_USER/hostdir
COPY packages/ /home/$NB_USER/packages/
COPY notebooks/ /home/$NB_USER/notebooks/
COPY nbextensions/ /home/$NB_USER/nbextensions/
COPY Dockerfile /root/work/.backup
COPY README.md /root/work/.backup
COPY *.sh /root/work/.backup/
COPY *.sh /home/$NB_USER/
RUN chown -R $NB_USER /home/$NB_USER
RUN chmod a+w -R /root/work
RUN chmod a+w -R /home/$NB_USER
RUN chmod a+x /home/$NB_USER/*.sh
RUN chmod a+x /home/$NB_USER/packages/*.sh

# Install Python, R and notebook extension packages
# RUN bash /home/jupyterhub/packages/python-packages.sh
# RUN bash /home/jupyterhub/packages/python-gis-packages.sh
# RUN bash /home/jupyterhub/packages/python-nlp-packages.sh
# RUN bash /home/jupyterhub/packages/r-packages.sh
# RUN bash /home/jupyterhub/packages/r-gis-packages.sh
# https://github.com/ipython-contrib/IPython-notebook-extensions
RUN bash /home/jupyterhub/nbextensions/nbextensions-packages.sh

# replace Python with PyPy!
RUN sed -i 's/python3/pypy/g' /usr/local/bin/jupyter

WORKDIR /home/$NB_USER
VOLUME /home/$NB_USER/hostdir

# Expose ports
EXPOSE 8888
EXPOSE 8956
EXPOSE 8957
EXPOSE 8081
EXPOSE 8000

ENTRYPOINT ["/tini", "--"]

CMD ["/bin/bash"]

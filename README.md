# docker-jupyterhub

## Two ways to set up the container

### 1. Pull the image from Docker Hub
This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 kernels. To use this base build for building the docker images that has additional kernels in this repository do a:

<code>
$ docker pull hermantolentino/jupyterhub:latest
</code>

This will download the base build which you can use to run Python 2 and 3 notebooks.

### 2. Build it from the Dockerfile

Follow these steps if you want to build the container from the Dockerfile.

1. On the command line: <code>$ git clone</code> this repository.
2. Download Anaconda from Continuum Analytics and place the file in the same folder as this Dockerfile.
3. Run this code on the command line: <code>$ docker build -t epispider/jupyterhub .</code> Remember the period. This will take a while.

## Running the container

1. Run the docker image: <code>$ docker run -it -p 0.0.0.0:8000:8000 <DOCKER IMAGE ID> /bin/bash</code>. You can obtain the DOCKER IMAGE ID by <code>$ docker images</code>. This will bring you to the docker container root prompt: <code>root@<DOCKER IMAGE ID>:~/work#</code>. At the root prompt type: <code># bash startjupyterhub.sh</code>. This will start your JupyterHub server.
2. Open a browser and type in <code>https://localhost:8000/</code>. On the Mac, you may have to substitute "localhost" with the docker machine IP address. The SSL certificates are self-signed so you will get a browser warning about the site being insecure. 
3. Find the username and password for JupyterHub inside the Dockerfile. You can create another user by logging in to the bash prompt of the container and using <code># adduser <username></code>.

## Notes

1. The JupyterHub configuration file at <code>/etc/jupyterhub/jupyterhub_config.py</code> has an insecure configuration. Please read the docs to create a secure configuration for your JupyterHub server.

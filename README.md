# docker-jupyterhub

This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 kernels. To use this base build for building the docker images that has additional kernels in this repository do a:

<code>
$ docker pull hermantolentino/jupyterhub:latest
</code>

This will download the base build which you can use to run Python 2 and 3 notebooks.

## Steps to use this Dockerfile

1. On the command line: <code>$ git clone</code> this repository.
2. Download Anaconda from Continuum Analytics and place the file in the same folder as this Dockerfile.
3. Run this code on the command line: <code>$ docker build -t epispider/jupyterhub .</code> Remember the period. This will take a while.
4. Run the docker image: <code>$ docker run -it -p 0.0.0.0:8000:8000 <DOCKER IMAGE ID> /bin/bash</code>. You can obtain the DOCKER IMAGE ID by <code>$ docker images</code>. This will bring you to the docker container root prompt: <code>root@<DOCKER IMAGE ID>:~/work#</code>. At the root prompt type: <code># bash startjupyterhub.sh</code>. This will start your JupyterHub server.
5. Open a browser and type in <code>http://localhost:8000/</code>. On the Mac, you may have to substitute "localhost" with the docker machine IP address.

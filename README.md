# docker-jupyterhub

This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 kernels. To use this base build for the other kernels in this repository do a:

<code>
$ docker pull hermantolentino/jupyterhub:latest
</code>

This will download the base build which you can use to run Python 2 and 3 notebooks.

## Steps

Download Anaconda and place it in the same folder as the Dockerfile.

<code>
$ docker build -t epispider/jupyterhub .
</code>

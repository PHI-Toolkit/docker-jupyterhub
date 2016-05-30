Note: This JupyterHub and Jupyter Notebook package was built without Anaconda.

## Two ways to set up the container

### 1. Pull the image from Docker Hub
This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 and R kernels. To use this base build for building the docker images that has additional kernels in this repository do a:

<code>
$ docker pull hermantolentino/jupyterhub:latest
</code>

This will download the base build which you can use to run Python 2 and 3 notebooks.

### 2. Build it from the Dockerfile

Follow these steps if you want to build the container from the Dockerfile.

1. On the command line: <code>$ git clone</code> this repository.
2. <code>$ cd docker-jupyterhub</code>
3. Run this code on the command line: <code>$ docker build -t hermantolentino/jupyterhub:v3 .</code> Remember the period - it means use the Dockerfile in the current directory. This will take a while. Make some coffee.

## Running the container

1. Run the docker image: <code>$ docker run -v $(pwd):/home/jupyter -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v3 /bin/bash</code>. <code>$(pwd) substitutes your current directory in the commend</code>. <code>-v</code> creates a shared volume that enables you to access this current host directory inside the container. This will bring you to the docker container root prompt: <code>root@<DOCKER IMAGE ID>:~/work#</code>.
2. Load the R and Python packages by typing at the command line: <code>$ ./installpackages.sh</code> . This will take a while again. If there are any errors, please let me know.
3. After loading the packages, you are now ready to launch JupyterHub. At the root prompt type: <code># bash startjupyterhub.sh</code>. This will start your JupyterHub server.
4. Open a browser and type in <code>https://localhost:8000/</code>. On the Mac, you may have to substitute "localhost" with the docker machine IP address. The SSL certificates are self-signed so you will get a browser warning about the site being insecure.
5. Find the username and password for JupyterHub inside the Dockerfile. You can create another user by logging in to the bash prompt of the container and using <code># adduser <username></code>.
6. Click on the packages directory and run the notebooks (files ending in .ipynb) to check the versions of the loaded kernels.

Enjoy!

## Notes

1. The JupyterHub configuration file at <code>/etc/jupyterhub/jupyterhub_config.py</code> has an insecure configuration. Please read the docs to create a secure configuration for your JupyterHub server.

# docker-jupyterhub

Note: This JupyterHub and Jupyter Notebook package was built without Anaconda.

## Two ways to set up the container

### 1. Pull the image from Docker Hub
This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 and R 3.3.0 and Scala 2.11 kernels. To use this base build for building docker images that have additional kernels in this repository do a:

```
$ docker pull hermantolentino/jupyterhub:latest
```

This will download the base build which you can use to run Python 2 and 3, R and Scala notebooks.

### 2. Build it from the Dockerfile

Follow these steps if you want to build the container from the Dockerfile.

1. On the command line: `$ git clone` this repository.
2. `$ cd docker-jupyterhub`
3. Run this code on the command line: `$ docker build -t hermantolentino/jupyterhub:v3 .` Remember the period - it means use the Dockerfile in the current directory. This will take a while. Make some coffee.

## Running the container

1. Run the docker image: `$ docker run -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v3 /bin/bash`. `$(pwd)` substitutes your current directory in the command. `-v` creates a shared volume that enables you to access this current host directory inside the container. This will bring you to the docker container root prompt: `root@"DOCKER IMAGE ID":/home/jupyterhub#`.
2. Load the R and Python data science packages by typing at the command line: `# ./installpackages.sh` . This will take a while again, have some coffee. If there are any errors, please let me know.
3. After loading the packages, you are now ready to launch JupyterHub. At the root prompt type: `# bash startjupyterhub.sh`. This will start your JupyterHub server.
4. Open a browser and type in `https://localhost:8000/`. On the Mac, you may have to substitute "localhost" with the docker machine IP address. The SSL certificates are self-signed so you will get a browser warning about the site being insecure.
5. Find the username and password for JupyterHub inside the Dockerfile. You can create another user by logging in to the bash prompt of the container and using `# adduser "username"`.

## Setting up packages and run version test notebooks
1. To test if the kernels load correctly, you need to load and run the notebooks in the `notebooks` directory from the Jupyter Notebook web interface. Click on each notebook (ends with .ipynb) and press the "run code" button. If the kernels are loaded correctly, you will see the version number of the kernel that runs each notebook.
2. To load the data science packages in the `packages` directory, you need to SSH or login to a container bash shell other than the one you ran JupyterHub from. Type ``$ docker exec -it "CONTAINER ID or CONTAINER alias" /bin/bash` to do this.
3. Once in the container root prompt, to load all the packages for R and Python, at the root prompt, type `# ./installpackages.sh`. This will run the scripts for R and Python. **Warning: This really takes a long time!**
4. If you want to load packages in batches, run the following scripts one after the other, at the root prompt: `# packages/r-packages.sh`, `# packages/python-packages.sh`, and `# packages/download_nltk-data.sh`. An option for the third package, which installs NLTK data is to load them as needed at run time (in the notebook) using nltk.download('ID of data set'). The complete set of NLTK data, and the `ID` you need to use for each set, is found here: http://www.nltk.org/nltk_data/.

## Stopping the container

1. You can stop jupyterhub by pressing `^C` twice, this will bring you back to the root prompt.
2. Remember, when you delete the JupyterHub container with `# docker rmi "CONTAINER ID"` all the packages you have installed will be gone. You can do a `# docker commit` before deleting the container instance. Running container instances are listed with `# docker ps`. Running and stopped instances are listed with `# docker ps -a`.

## Notes

1. The JupyterHub configuration file at `/etc/jupyterhub/jupyterhub_config.py` has an insecure configuration. Please read the docs to create a secure configuration for your JupyterHub server.
2. If you want to run JupyterHub from a folder on your computer that has notebooks, ` cd ` to that folder and use: `# docker run -v $(pwd):/home/jupyterhub -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v3 /bin/bash`. This will substitute your notebook folder for the default container folder `/home/jupyterhub`.

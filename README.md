# docker-jupyterhub

Note: This JupyterHub and Jupyter Notebook package was built without Anaconda. Source code is available at https://github.com/hermantolentino/docker-jupyterhub.

## Two ways to set up the container

### 1. Pull the image from Docker Hub
This is the base build that runs JupyterHub and Jupyter Notebooks with Python 2 and 3 and R 3.3.0 and Scala 2.11 kernels. Check the "Build Details" link on the Docker page to see if there is any new base build on queue. To use this base build for building docker images that have additional kernels in this repository do a:

> ```
> $ docker pull hermantolentino/docker-jupyterhub:latest
> ```

This will download the base build which you can use to run Python 2 and 3, R and Scala notebooks. To use this as the base for a new Dockerfile, use the label above in the `FROM:` section of your new Dockerfile. Before "pulling", check the tag for the latest automated build (it may not say 'latest', could be 'v4' or 'v5'), and attach that tag to the label (hermantolentino/docker-jupyterhub:**"TAG HERE"**).

### 2. Build it from the Dockerfile

Follow these steps if you want to build the container from the Dockerfile from scratch on your machine.

1. On the command line: `$ git clone` this repository.
2. `$ cd docker-jupyterhub`
3. Run this code on the command line: `$ docker build -t hermantolentino/jupyterhub:v5 .` Remember the period - it means use the Dockerfile in the current directory and use that directory as __context__ (this enables you use Docker instructions, like `ADD` or `COPY` that copy files from that directory to your container). This will take a while. Make some coffee.

## Running the container

1. There are two ways to run the docker image:

 1.1 **Self-contained mode**: Docker container you launch will have no access to any host drive directory. Run `$ docker run -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v5 /bin/bash`.

 1.2 **Using current host directory as work directory**: Run `$ docker run -v $(pwd):/home/jupyterhub/hostdir -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v5 /bin/bash``$(pwd)` substitutes your current directory in the command. `-v` creates a shared volume that enables you to access your current host directory (from where you launch the docker container) inside the container.

2. This will bring you to the docker container root prompt: `root@"DOCKER IMAGE ID":/home/jupyterhub/#`. In mode 1.1 above when you `cd` to `hostdir` you will enter a blank directory. In mode 1.2 above, you will find the files present in the current host directory from where you launched the container.

3. Next, load the R and Python data science packages - See "Setting up packages" below. This will take a while again, have some coffee. If there are any errors, please let me know.

4. After loading the packages, you are now ready to launch JupyterHub. At the root prompt type: `# bash startjupyterhub.sh`. This will start your JupyterHub server.

5. Open a browser and type in `https://localhost:8000/`. On the Mac, you may have to substitute "localhost" with the docker machine IP address. The SSL certificates for `https` are self-signed so you will get a browser warning about the site being insecure.

6. Find the username and password for JupyterHub inside the Dockerfile. You can create another user by logging in to the bash prompt of the container and using `# adduser "username"`.

## Setting up packages and run version test notebooks
1. To test if the kernels load correctly, you need to load and run the notebooks in the `notebooks` directory from the Jupyter Notebook web interface. Click on each notebook (ends with .ipynb) and press the "run code" button. If the kernels are loaded correctly, you will see the version number of the kernel that runs each notebook.

2. To load the R and Python data science packages in the `packages` directory, you need to login to a container bash shell other than the one you ran JupyterHub from. Type ``$ docker exec -it "CONTAINER ID or CONTAINER alias" /bin/bash` to do this.

3. Once in the container root prompt, to load all the packages for R and Python, at the root prompt, type `# ./installpackages.sh`. This will run the scripts for R and Python. **Warning: This really takes a long time!**

4. If you want to load packages in batches, run the following scripts one after the other, at the root prompt: `# packages/r-packages.sh`, `# packages/python-packages.sh`, and `# packages/python-nlp-packages.sh`. Installing additional packages takes time:

 4.1 **NLTK**: Install NLTK package and NLTK data. This takes a long while so one option is to load them as needed at run time (in the notebook) using nltk.download('ID of data set'). The complete set of NLTK data, and the `ID` of the data set you need to use, is found here: http://www.nltk.org/nltk_data/.

 4.2 **GIS**: Install the Python GIS package.

 4.3 **NLP**: Install the Python NLP package.

## Installed notebooks

This container has a `notebooks` directory where there are sample notebooks installed and ready to run. Some of the notebooks would require packages that you might have not been installed yet, e.g., the GIS package and you will see an error that says a module is not installed.

## Stopping the container

1. You can stop jupyterhub while inside the container by pressing `^C` twice, this will bring you back to the root prompt.

2. Remember, when you delete the JupyterHub container with `# docker rmi "CONTAINER ID"` all the packages you have installed will be gone. You can do a `# docker commit` before deleting the container instance. Running container instances are listed with `# docker ps`. Running and stopped instances are listed with `# docker ps -a`.

## Using Dockerfile-packages

`Docker-packages` is the Dockerfile to use to build JupyterHub with R and Python data science packages. Run this Docker container package if you want to build jupyterhub with R and Python data science packages. It is a big container (~4-5GB) and takes a while to build (depends on your machine specs). To build this container, use the `hermantolentino/jupyterhub:v5` host directory as the context but use `Dockerfile-packages` as the Dockerfile specification:

> `
> $ docker build -t hermantolentino/jupyter-packages:v1 -f Dockerfile-packages .`
>


## Notes

1. The JupyterHub configuration file at `/etc/jupyterhub/jupyterhub_config.py` has an insecure configuration. Please read the docs to create a secure configuration for your JupyterHub server.

2. If you want to run JupyterHub and use a folder on your computer that has your notebooks, ` cd ` to that folder and use: `# docker run -v $(pwd):/home/jupyterhub/hostdir -it -p 0.0.0.0:8000:8000 hermantolentino/jupyterhub:v5 /bin/bash`. This will make your notebook folder visiable in the container folder `/home/jupyterhub/hostdir`.

# Docker image/container for HERE Data SDK for Python
Sample docker image for [HERE Data SDK for Python](https://developer.here.com/documentation/sdk-python-v2/dev_guide/index.html).

This image is based on [micromamba-docker](https://hub.docker.com/r/mambaorg/micromamba)

## Prerequisities
In order to run this container you'll need docker installed.

Only Windows version are tested.

* [Windows](https://docs.docker.com/windows/started)

Probably works with Mac and Linux as well, but not tested.

## Usage

### Packages and installed environment
Python packages will be installed into the "base" environment via conda-forge channel.

You can modify installed packages with `env.yaml` file.

### Credential
You need to setup your credential to use HERE Data SDK for Python. Please create directory named `credentials` and place your credential file (`credentials.properties`)in that directory. The credential file will be copied to the `/root/.here` directory in container, so you will be able to use the SDK soon after the container created.

If you don't know how to get credential, please refer [Credentials Setup](https://developer.here.com/documentation/sdk-python-v2/dev_guide/topics/credentials.html).

### Volumes
Volumes mounted to the container is specified in `docker-compose.yml`. Please change the `volumes` part to your original one.

### How to run
Run the `docker-compose up`. Jupyter Lab will start up automatically, then copy and paste the URL with your browser. The 8888 port is used for the Jupyter.

Next time you start the container, run `docker container start here-pysdk -i`.

### Japanese locale
If you do not need Japanese locale, please remove corresponding part in Dockerfile.

## Author

* Hiromu Nakamura

## License

The codes inside of this project are released under the MIT License, see [LICENSE.md](LICENSE.md).

Please refer [Legal, privacy & security](https://legal.here.com/en-gb) about HERE Technologies products.
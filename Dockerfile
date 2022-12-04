ARG here_version="2.14.0"

# Base image
FROM mambaorg/micromamba:latest

LABEL maintainer="Hiromu Nakamrua"
LABEL description="Micormamba container with HERE Data SDK for Python ${here_version}"
LABEL version="1.2"

# Configure Japanese environment -------------
ENV LANG ja_JP.UTF-8

USER root

RUN apt-get update && \
    apt-get install -y \
        locales \
        fonts-ipaexfont && \
    localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && \
    apt-get clean
# -------------------------------------------

# Copy env.yml file
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yml /tmp/env.yml

USER $MAMBA_USER

RUN micromamba install -y -n base -f /tmp/env.yml && \
    micromamba clean --all --yes

# Copy credential file of HERE Platform
COPY ./credentials/credentials.properties /home/$MAMBA_USER/.here/

# Set working directory in the cotainer.
# Directory name after $MAMBA_USER can be modified, but should be the same as the directory name in the volume part of the docker-compose.yml
WORKDIR /home/$MAMBA_USER/share_w_host

EXPOSE 8888

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser"]
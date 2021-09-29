ARG here_version="2.4.0"

# Base image
FROM mambaorg/micromamba:latest

LABEL maintainer="moorca"
LABEL description="Micormamba container with HERE Data SDK for Python ${here_version}"
LABEL version="1.0"

# Japanese env -----------------------------------
ENV LANG ja_JP.UTF-8
# ------------------------------------------------

# Copy yml file
COPY --chown=micromamba:micromamba env.yaml /tmp/env.yaml

USER root

RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes && \
    mkdir /root/.here && \
    # Install Japanese locale -------------------
    apt-get update && \
    apt-get install -y \
        locales \
        fonts-ipaexfont && \
    localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && \
    apt-get clean
    # -------------------------------------------

COPY ./credentials/credentials.properties /root/.here

WORKDIR /home/share_w_host

EXPOSE 8888

CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--allow-root"]
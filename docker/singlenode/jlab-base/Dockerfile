# Image name: harbor.cloud.infn.it/datacloud-templates/jlab-base:2.1.1

ARG BASE_IMAGE="quay.io/jupyter/minimal-notebook:ubuntu-22.04" 
FROM ${BASE_IMAGE}

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Basic O.S. packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        fuse \
        git \
        graphviz \
        jq \
        less \
        #libargon2-0-dev \
        libcairo2-dev \
        libczmq-dev \
        libffi-dev \
        libjpeg-dev \
        libpixman-1-dev \
        nano \
        openssh-client \
        pandoc \
        rsync \
        screen \
        snakemake \
        software-properties-common \
        texlive-base \
        texlive-fonts-recommended \
        texlive-xetex \
        tini \
        vim \
        wget && \
        apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Jupyterlab componentes
RUN python3 -m pip install --no-cache-dir \
        dask-labextension \
        h5py \
        ipywidgets  \
        jupyter-resource-usage  \
        jupyter_telemetry  \
        jupyterlab-git  \
        jupyterlab-logout \
        jupyterlab-nvdashboard \
        jupyterlab-theme-toggler \
        jupyterlab-topbar-text \
        jupyterlab-widgets \
        matplotlib \
        nbclassic \
        nbclient \
        nbconvert \
        nbdime \
        nbformat \
        numpy \
        pandas \
        tornado 

# Install vscode
# Old: https://code-server.dev/install.sh
RUN curl -fsSL https://raw.githubusercontent.com/cdr/code-server/main/install.sh | sh
RUN python3 -m pip install \ 
        git+https://github.com/infn-datacloud/jupyter_codeserver_proxy.git \
        jupyter-resource-usage \
        jupyter-server-proxy 

ENV CVMFS_PARENT_DIR=/jupyter-workspace
ENV PATH=/jupyter-workspace/cvmfs/datacloud.infn.it/sw/sts-wire/linux/2.1.5/bin:$PATH
USER root
WORKDIR /jupyter-workspace

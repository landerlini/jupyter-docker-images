# Image name: harbor.cloud.infn.it/datacloud-templates/jlab-naas:2.1.1

ARG BASE_IMAGE="jupyterhub/k8s-singleuser-sample:4.3.0"
FROM ${BASE_IMAGE}

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Use bash instead of dash (can also use "ENV SHELL=/bin/bash")
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm /bin/sh && ln -s /bin/bash /bin/sh 

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
        rclone \
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

# Install vscode
RUN curl --retry 5 --retry-delay 2 --retry-all-errors -fsSL https://code-server.dev/install.sh | sh
RUN python3 -m pip install \ 
        git+https://github.com/infn-datacloud/jupyter_codeserver_proxy.git \
        jupyter-resource-usage \
        jupyter-server-proxy 

# Install Jupyterlab componentes
RUN python3 -m pip install --no-cache-dir \
    boto3==1.35.99 \
    dask-labextension \
    h5py \
    ipywidgets  \
    jupyter-resource-usage  \
    jupyter_telemetry  \
    jupyterlab-git  \
    jupyterlab-logout \
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

# Install oidc-agent
RUN apt update && \
    apt install -y oidc-agent && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# # Install sts-wire
# ADD https://repo.cloud.cnaf.infn.it/repository/sts-wire/sts-wire-linux/2.1.5/sts-wire-linux-2.1.5 /usr/local/bin/sts-wire
# RUN chmod +x /usr/local/bin/sts-wire

COPY jupyterhub-singleuser /usr/local/bin/jupyterhub-singleuser
COPY spawn.sh /jupyterlab-workspace/.init/spawn.sh

# Copy Rclone files
COPY rclone-aws.config /jupyterlab-workspace/.init/rclone-aws.config
COPY rclone-cmd.sh /jupyterlab-workspace/.init/rclone-cmd.sh
COPY rclone-sts.py /jupyterlab-workspace/.init/rclone-sts.py
COPY rclone-sts.sh /jupyterlab-workspace/.init/rclone-sts.sh
COPY rclone-token.sh /jupyterlab-workspace/.init/rclone-token.sh
COPY rclone.config /jupyterlab-workspace/.init/rclone.config

RUN chmod +x /usr/local/bin/jupyterhub-singleuser && \
    chmod +x /jupyterlab-workspace/.init/*.sh && \
    chmod +x /jupyterlab-workspace/.init/*.py 

COPY bashrc /home/jovyan/.bashrc
ENV PWD=/jupyterlab-workspace
WORKDIR /jupyterlab-workspace

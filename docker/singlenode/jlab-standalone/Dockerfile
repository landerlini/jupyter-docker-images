# Image name: harbor.cloud.infn.it/datacloud-templates/jlab-standalone:2.1.1
ARG BASE_IMAGE="harbor.cloud.infn.it/datacloud-templates/jlab-base:2.1.1" 
FROM ${BASE_IMAGE}

USER root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install oidc-agent
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends oidc-agent && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

# Install sts-wire
ADD https://repo.cloud.cnaf.infn.it/repository/sts-wire/sts-wire-linux/2.1.5/sts-wire-linux-2.1.5 /usr/local/bin/sts-wire
RUN chmod +x /usr/local/bin/sts-wire

# Remove unused jupyterlab-nvdashboard module and use bash instead of dash
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm /bin/sh && ln -s /bin/bash /bin/sh && \
    pip uninstall -y jupyterlab-nvdashboard

ENTRYPOINT [ "/opt/conda/bin/jupyterhub-singleuser" ]
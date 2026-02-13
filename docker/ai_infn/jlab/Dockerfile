# Image name: harbor.cloud.infn.it/datacloud-templates/jlab-ai-infn:2.1.1-ai1.5" 
ARG BASE_IMAGE="harbor.cloud.infn.it/datacloud-templates/jlab-base:2.1.1" 
FROM ${BASE_IMAGE}

# RUN splitted to Install apptainer, cvmfs and openssh-server
# Install apptainer, cvmfs and openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt install -y gnupg2 && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        lsb-release \
        software-properties-common \
        wget && \
    wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb && \
    dpkg -i cvmfs-release-latest_all.deb && \
    add-apt-repository -y ppa:apptainer/ppa && \
    apt update --allow-unauthenticated && \
    apt install -y \
      apptainer \
#      cvmfs \
#      cvmfs-fuse3 \
      cvmfs-libs \
      libgl1-mesa-glx \    
      openssh-server \
      xvfb \
      # Remote desktop:
      dbus-x11 \
      xorg \
      xfce4 xfce4-panel xfce4-session xfce4-settings breeze-icon-theme kde-plasma-desktop \
      tigervnc-standalone-server \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* cvmfs-release-latest_all.deb 

# Update conda and python version
RUN conda update -n base -c conda-forge conda && \
    conda update -n base python
    
# Install snakemake Python modules
RUN python3 -m pip install --no-cache-dir \
      jupyter-remote-desktop-proxy \
      snakemake-executor-plugin-cluster-generic>=1 \
      snakemake-storage-plugin-s3 \
      git+https://github.com/landerlini/snakemake-storage-plugin-webdav \
      git+https://github.com/landerlini/snakemake-storage-plugin-fs \
      git+https://github.com/landerlini/snakemake-storage-helper \
      snakemake>=9.11

# Install customized JuiceFS client
ADD https://pandora.infn.it/public/3423df/dl/juicefs /usr/bin/juicefs 
RUN chmod a+rx /usr/bin/juicefs 

# Install sts-wire
ADD https://repo.cloud.cnaf.infn.it/repository/sts-wire/sts-wire-linux/2.1.5/sts-wire-linux-2.1.5 /usr/local/bin/sts-wire
RUN chmod +x /usr/local/bin/sts-wire

# Changes the home directory of the user to private
RUN sed -i 's/:\/root:/:\/home\/private:/g' /etc/passwd

# Import configuration of sshd
COPY ./sshd.conf /etc/ssh/sshd_config.d/aiinfn.conf 

# Enable defining secondary groups through env var $NB_GROUPS
COPY ./create_user_groups.py /usr/local/bin/before-notebook.d/05_create_user_groups.py
RUN chmod a+rx /usr/local/bin/before-notebook.d/05_create_user_groups.py

RUN echo "rm -rf /home/jovyan" >  /usr/local/bin/before-notebook.d/99_cleanup_jovyan.sh 
RUN chmod a+rx                    /usr/local/bin/before-notebook.d/99_cleanup_jovyan.sh 

WORKDIR /home

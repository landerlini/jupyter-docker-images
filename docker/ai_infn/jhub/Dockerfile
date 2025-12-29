FROM quay.io/jupyterhub/k8s-hub

# Import the shell scripts
COPY *.sh /usr/local/etc/jupyterhub/jupyterhub_config.d/

# Import the html and css templates
COPY *.html /usr/local/etc/jupyterhub/jupyterhub_config.d/
COPY *.css /usr/local/etc/jupyterhub/jupyterhub_config.d/

# Import the custom configurations
COPY *.py /usr/local/etc/jupyterhub/jupyterhub_config.d/


#!/bin/bash

# Configure oidc-agent for user token management
echo "eval \`oidc-keychain\`" >> ~/.bashrc
eval `OIDC_CONFIG_DIR=$HOME/.config/oidc-agent oidc-keychain`
oidc-gen infncloud --issuer $IAM_SERVER \
--client-id $IAM_CLIENT_ID \
--client-secret $IAM_CLIENT_SECRET \
--rt $REFRESH_TOKEN \
--confirm-yes \
--scope "openid profile email" \
--redirect-uri http://localhost:8843 \
--pw-cmd "echo \"DUMMY PWD\""

kill `ps faux | grep rclone | grep ".${USERNAME}" | awk '{ print $2 }'`
kill `ps faux | grep rclone | grep ".scratch" | awk '{ print $2 }'`

mkdir -p /jupyterlab-workspace/s3/
mkdir -p /jupyterlab-workspace/local/
mkdir -p /jupyterlab-workspace/s3/${USERNAME}
mkdir -p /jupyterlab-workspace/s3/scratch

/jupyterlab-workspace/.init/rclone-cmd.sh


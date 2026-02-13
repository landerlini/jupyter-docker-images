apt update && apt install -y rclone
pip install --upgrade pip
pip install boto3==1.35.99
# mkdir /jupyterlab-workspace/s3-rclone/
chmod +x /jupyterlab-workspace/.init/*.sh /jupyterlab-workspace/.init/*.py
mkdir -p /jupyterlab-workspace/s3-rclone/$USERNAME
mkdir -p /jupyterlab-workspace/s3-rclone/scratch
/jupyterlab-workspace/.init/rclone-cmd.sh

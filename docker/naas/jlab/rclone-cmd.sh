#!/bin/bash
BASE_DIR=/jupyterlab-workspace/.init

AWS_CONFIG_FILE=$BASE_DIR/rclone-aws.config rclone --config $BASE_DIR/rclone.config mount rgw:/$USERNAME /jupyterlab-workspace/s3/$USERNAME &
AWS_CONFIG_FILE=$BASE_DIR/rclone-aws.config rclone --config $BASE_DIR/rclone.config mount rgw:/scratch /jupyterlab-workspace/s3/scratch &

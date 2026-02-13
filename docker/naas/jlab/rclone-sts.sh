#!/bin/bash

cd "$(dirname $0)"

export ACCESS_TOKEN=$(./rclone-token.sh)
AWS_CRED="$(./rclone-sts.py)"
echo "${AWS_CRED}"

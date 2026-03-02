#!/bin/bash

# Retrieve username from env var
NB_USER="${NB_USER}"

SETUP_SCRIPT=${SETUP_SCRIPT:-"/envs/setup.sh"} 
LOG_FILE="/var/log/envs-setup.log"

if [ -z "$NB_USER" ]; then
	echo "NB_USER environment variable not set."
	exit 0
fi


if [ -f "$SETUP_SCRIPT" ]; then
	# Run setup script as NB_USER in background with 5 min timeout
	(
		sudo -u "$NB_USER" timeout 300 bash "$SETUP_SCRIPT" 2>&1 | sudo tee "$LOG_FILE" > /dev/null
	) &
else
	echo "$SETUP_SCRIPT does not exist."
fi


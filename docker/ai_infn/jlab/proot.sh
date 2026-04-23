#!/bin/bash

# This script is a wrapper to execute apptainer sandboxes using proot, allowing to run them without root privileges.

proot \
    --bind=/dev \
    --bind=/var/tmp \
    --bind=/home \
    --bind=/etc/passwd \
    --bind=/etc/group \
    --bind=/etc/shadow \
    --bind=/etc/sudoers \
    --bind=/cvmfs \
    --bind=/proc \
    "$@"
#!/bin/env python3
"""
Simple script creating groups for the NB_USER based on NB_GROUPS env var.
The script is intended for Jupyter docker images inherinting from docker-stacks-foundation 
and should be installed in /usr/local/bin/before-notebook.d/

The format of the NB_GROUPS env var is:
  NB_GROUPS=gid:group[,gid2:group2[, ...]]

For example,
  NB_GROUPS=4001:lhcb,4002:cms,4003:atlas

"""

import os
import subprocess
import traceback


print (f"Processing NB_GROUPS={os.environ.get('NB_GROUPS', '')}")
groups = os.environ.get("NB_GROUPS", "").split(", ")
username = os.environ.get("NB_USER", os.environ.get("JUPYTERHUB_USER", "jovyan"))

with open("/etc/subuid", "w") as f:
  f.write("%(username)s:100000:65536" % dict(user=username))
with open("/etc/subgid", "w") as f:
  f.write("%(username)s:100000:65536" % dict(user=username))

for group in groups:
    try:
        gid, groupname = group.split(":")
        subprocess.run(["addgroup", "--gid", gid, groupname])
        subprocess.run(["adduser", username, groupname])
    except:
        traceback.print_exc()
        print ("Failed processing group: ", group)



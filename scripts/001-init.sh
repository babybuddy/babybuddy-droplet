#!/bin/bash

set -o errexit

# Add executable bit to scripts.
chmod 700 /var/lib/cloud/scripts/per-instance/001_onboot.sh
chmod 755 /etc/update-motd.d/99-babybuddy

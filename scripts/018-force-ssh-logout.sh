#!/bin/sh

cat >> /etc/ssh/sshd_config <<EOM
Match User root
        ForceCommand echo "Setting up Baby Buddy. Please try again in a moment..."
EOM

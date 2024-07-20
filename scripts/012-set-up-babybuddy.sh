#!/bin/bash

set -o errexit

# Create the babybuddy user.
useradd --system babybuddy

# Set up project directories.
mkdir /var/www/babybuddy
chown -R babybuddy: /var/www/babybuddy
mkdir -p /var/www/babybuddy/data/media
git config --global advice.detachedHead false
git clone --depth 1 --branch "${BRANCH_OR_TAG}" https://github.com/babybuddy/babybuddy.git /var/www/babybuddy/public

# Install depenencies.
pipx ensurepath
pipx install --quiet pipenv
cd /var/www/babybuddy/public || exit
PIPENV_VENV_IN_PROJECT=1 /root/.local/bin/pipenv install

# Install extra package for IP discovery support.
/root/.local/bin/pipenv install netifaces

# Enable uwsgi app.
ln -s /etc/uwsgi/apps-available/babybuddy.ini /etc/uwsgi/apps-enabled/babybuddy.ini

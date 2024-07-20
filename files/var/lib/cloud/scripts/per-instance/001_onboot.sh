#!/bin/bash -x
exec > >(tee /var/log/one_click_setup.log) 2>&1

PROJECT_DIR=/var/www/babybuddy
BABYBUDDY_DIR="${PROJECT_DIR}/public"
DATA_DIR="${PROJECT_DIR}/data"
SETTINGS_DIR="${BABYBUDDY_DIR}/babybuddy/settings"
SETTINGS_FILE="${SETTINGS_DIR}/droplet.py"

# Generate some passwords
cat > /root/.secrets <<EOM
BABYBUDDY_USER=babybuddy
BABYBUDDY_USER_PASSWORD=$(openssl rand -hex 16)
SECRET_KEY=$(openssl rand -hex 16)
EOM

echo "SETTINGS_FILE=$SETTINGS_FILE" >> /root/.secrets

source /root/.secrets

# Create the settings file
cp -r "/var/lib/digitalocean/droplet.py" "${SETTINGS_FILE}"

# Set the django user password
echo "${BABYBUDDY_USER}:${BABYBUDDY_USER_PASSWORD}" | chpasswd -

sed -e "s/@SECRET_KEY@/${SECRET_KEY}/" \
    -i "${SETTINGS_FILE}"

# Set up the database
cd "${BABYBUDDY_DIR}" || exit
DJANGO_SETTINGS_MODULE=babybuddy.settings.droplet /root/.local/bin/pipenv run python manage.py migrate --noinput
chown -R www-data:www-data "${DATA_DIR}"
chmod 640 "${DATA_DIR}/db.sqlite3"
chmod 750 "${DATA_DIR}"

# Restart services
systemctl restart uwsgi
systemctl restart nginx

# Remove the ssh force logout command
sed -e '/Match User root/d' \
    -e '/.*ForceCommand.*Baby Buddy.*/d' \
    -i /etc/ssh/sshd_config

systemctl restart ssh

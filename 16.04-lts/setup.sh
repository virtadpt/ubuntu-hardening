#!/bin/bash

# by: drwho at virtadpt dot net

# Copies all this stuff into place on a brand-new system to harden it.  Also
# installs some useful packages for monitoring.

# You must be this high <hand> to ride this ride.
if [ `id -u` -gt 0 ]; then
    echo "You must be root to update the $NAME codebase. ABENDing."
    exit 1
fi

# Patch the system.
apt-get upgrade -y

# Postfix sends mail.
# AIDE monitors the file system.
# Logwatch parses the logfiles and mails you about anomalies.
apt-get install -y postfix aide logwatch

# These are always good to have around.
apt-get install -y libpam-pwquality unattended-upgrades
apt-get install -y haveged openntpd lynx sslscan sysstat
apt-get install -y openssl-blacklist openssl-blacklist-extra
apt-get install -y openssh-blacklist openssh-blacklist-extra

# Install all the files.  All of them.
cp -rv * /etc

# Just not this one.
rm -f /etc/setup.sh

# Create /var/log/sulog.
touch /var/log/sulog
chown root:root /var/log/sulog
chmod 0640 /var/log/sulog

# Create the sudo log directory tree.
mkdir /var/log/sudo-io

# Set some file ownerships.
chown root:root /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/sudoers
chown -R root:root /var/spool/cron
chown root:syslog /var/log/sudo-io

# Set some file permissions.
chmod 0400 /etc/at.allow
chmod 0400 /etc/cron.allow
chmod 0400 /etc/crontab
chmod 0700 /etc/skel/.ssh
chmod 0600 /etc/skel/.ssh/authorized_keys
chmod 0440 /etc/sudoers
chmod 0700 /var/log/sudo-io

# Enable some system services.  `systemctl list-unit-files` is your friend.
systemctl enable acpid
systemctl enable sysstat

# Disable other system services.
systemctl disable iscsi
systemctl disable iscsid
systemctl disable mountnfs-bootclean
systemctl disable mountnfs
systemctl disable umountnfs

# Build the initial AIDE database.
echo "Building initial AIDE database.  Please be patient, this takes a while."
aide.wrapper --init
cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Fin.
exit 0


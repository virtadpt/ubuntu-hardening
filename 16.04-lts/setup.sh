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
apt-get install -y haveged openntpd lynx sslscan psmisc sysstat
apt-get install -y openssl-blacklist openssl-blacklist-extra
apt-get install -y openssh-blacklist openssh-blacklist-extra

# Install all the files.  All of them.
cp -rv * /etc

# Just not this one.
rm -f /etc/setup.sh

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


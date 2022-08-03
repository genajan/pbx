#!/bin/bash

# Handle signals
trap "/stop.sh ; exit" EXIT

HOST_IP=`ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p'`

if [ -d /etc/configs/asterisk ]; then
    cp /etc/configs/asterisk/* /etc/asterisk/
fi

chown -R kamailio:kamailio /etc/kamailio/
chown asterisk.asterisk /etc/asterisk/*

# Create symlink, asterisk can't find /etc/radiusclient-ng
ln -sfn /etc/radcli/ /etc/radiusclient-ng

# Apply host specific settings
sed -i "s/mydomain.com/$DOMAIN/" /etc/kamailio/vars.cfg /etc/monit/conf.d/kamailio.conf /etc/asterisk/pjsip_wizard.conf
sed -i "s/127.0.0.2/$HOST_IP/" /etc/kamailio/vars.cfg /etc/asterisk/pjsip.conf /etc/monit/conf.d/kamailio.conf
if grep -q localuserspassword "/etc/asterisk/pjsip_wizard.conf"; then
    LOCALUSERSPASSWORD=$(/usr/bin/openssl rand -hex 12)
    sed -i "s/localuserspassword/$LOCALUSERSPASSWORD/" /etc/asterisk/pjsip_wizard.conf
    echo "localuserspassword was replaced to: $LOCALUSERSPASSWORD"
fi

# Monit will start only if set right permissions
/bin/chmod 0700 /etc/monit/monitrc

# Monit will start all apps
/etc/init.d/monit restart
monit start all

# Stay up for container to stay alive
sleep infinity &
wait $!

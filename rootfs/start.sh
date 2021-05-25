#!/bin/bash

# Handle signals
trap "/stop.sh ; exit" EXIT

chown -R kamailio:kamailio /etc/kamailio/

# Create symlink, asterisk can't find /etc/radiusclient-ng
ln -sfn /etc/radcli/ /etc/radiusclient-ng

# Apply host specific settings
sed -i "s/mydomain.com/$DOMAIN/" /etc/kamailio/vars.cfg /etc/monit/conf.d/kamailio.conf /etc/asterisk/pjsip_wizard.conf
sed -i "s/127.0.0.2/$HOST_IP/" /etc/kamailio/vars.cfg /etc/asterisk/pjsip.conf /etc/monit/conf.d/kamailio.conf

# Monit will start all apps
/etc/init.d/monit restart
monit start all

# Stay up for container to stay alive
sleep infinity &
wait $!

#!/bin/bash

# handle signals
trap "/stop.sh ; exit" EXIT

chown -R kamailio:kamailio /etc/kamailio/

# Monit will start all apps
/etc/init.d/monit restart
monit start all

# Stay up for container to stay alive
sleep infinity &
wait $!

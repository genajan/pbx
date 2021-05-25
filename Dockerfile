FROM debian:buster-slim

MAINTAINER Gennadiy Ganchev <genajan@gmail.com>

# Monit package can be found at buster-backport repository
RUN echo "deb http://ftp.de.debian.org/debian buster-backports main" | \
  tee /etc/apt/sources.list.d/buster-backports.list \
  && apt-get update && apt-get install -y \
  apt-utils \
  procps \
  nano \
  curl \
  rsyslog \
  less \
  net-tools \
  libssl1.1 \
  libcurl4 \
  libxml2 \
  lsb-base \
  python \
  libncurses5 \
  libreadline7 \
  default-mysql-client \
  monit \
\
# Install kamailio
  kamailio \
  kamailio-websocket-modules \
  kamailio-utils-modules \
  kamailio-tls-modules \
  kamailio-sqlite-modules \
  kamailio-mysql-modules \
  kamailio-lua-modules \
# Install asterisk
  asterisk-opus \
  asterisk \
\
# Cleanup
  && rm -rf /packages && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY rootfs /
RUN LOCALUSERSPASSWORD=$(/usr/bin/openssl rand --base64 30) \
  && sed -i "s/localuserspassword/$LOCALUSERSPASSWORD/" /etc/asterisk/pjsip_wizard.conf \
  && echo "localuserspassword: $LOCALUSERSPASSWORD" \
  && chown asterisk.asterisk /etc/asterisk/*

ENTRYPOINT ["/start.sh"]


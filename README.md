# pbx
PBX in docker container based on Kamailio and Asterisk

## Getting Started
1. Obtain code
```
$ git clone https://github.com/genajan/pbx.git
```
2. Go to the project directory
```
$ cd pbx
```
3. Edit settings in 'rootfs/etc/kamailio/vars.cfg' and 'rootfs/etc/asterisk/pjsip.conf'. Set suitable IP addresses, ports and domain name.
4. Start container
```
$ docker-compose up -d
```
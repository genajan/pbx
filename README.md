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
3. Edit .env file. Set domain name if needed.
4. Start container
```
$ docker-compose up -d
```
5. Auto generated sip credentials can be found inside the container in /etc/asterisk/pjsip_wizard.conf
```
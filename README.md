# zabbix-Challenge

This repository contains the code and documentation for my submission of the NSW Education Zabbix Challenge (see https://github.com/semmersultan/zabbix-Challenge.git)

This challenge was very fun to do and the open ended style of the specification was challenging as I needed to select technologies that could work everywhere as well as being careful that I didn't go too far out of scope in the limited timeframe.

The application is a simple zabbix servers that responds on the following endpoints.
I have used the makefile to make things easier: to start

**make test-lint-yaml**
```
This will check the yml syntax before run the actual application
```

**make build**
```
This will build the one container image contain zabbix-server-mysql zabbix-frontend-php zabbix-agent
```
**make show**

```
show the latest image , e.g. zabbix-test:latest
```
**make deploy**
```
This will compose the latest build image and pass the environment variable from docker-compose file
-----------------compose the new build container
Creating zabbixchallenge_zabbix-semmer_1
Attaching to zabbixchallenge_zabbix-semmer_1
zabbix-semmer_1  | ==> Starting MySQL...
zabbix-semmer_1  | ==> Creating Zabbix database...
zabbix-semmer_1  | ==> Import initial schema and data.
```

# Assumptions

An assumption was made that the zabbix_server does not need to handle a large scale production workload but should be in a state that allows it to be consistently reviewed and tested.

# Technology Used

Zabbix - zabbix 4.0  {zabbix-server zabbix-agent apache2}.

Ubuntu - 16.04

makefile - use to simply the processes inase you need to bundle with CI/CD in future.

Docker - Docker satisfied the condition that the application be packaged as a deployable artifact with dependencies enclosed.

# To run the app locally

```
docker run -it zabbix-test  /bin/bash  

```

# Clone the repository and run the app
```
git clone https://github.com/semmersultan/zabbix-Challenge.git
cd zabbix-Challenge
make build && make deploy
```

# Reflections

There are several things I would like to improve with this project and fully intend to implement them in the future.

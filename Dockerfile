FROM  ubuntu:16.04
MAINTAINER Semmer Sultan , semmersultan@gmail.com


# Update Ubuntu Software repository

RUN apt-get update -y && apt-get install -y wget

RUN \
wget --no-check-certificate https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+xenial_all.deb \
&& dpkg -i zabbix-release_4.0-2+xenial_all.deb \
&& apt-get update -y \
&& apt-get install -y \
zabbix-server-mysql zabbix-frontend-php zabbix-agent python3-pip \
&& rm -rf /var/lib/apt/lists/*
RUN \
	mkdir -p /var/run/zabbix \
	&& chown zabbix.zabbix /var/run/zabbix

# configure timezone to Sydney
RUN sed -i \
	-e 's/# php_value date\.timezone Europe\/Riga/php_value date\.timezone Australia\/Sydney/' \
	/etc/zabbix/apache.conf \
# make a symbolic link
	&& ln -sf /usr/bin/python3 /usr/bin/python


# configureDBPassword to password
	RUN sed -i -e 's/# DBPassword/DBpassword\=password/' /etc/zabbix/zabbix_server.conf

# COPY the docker systemctl.py to repalce existing systemctl for starting service on startup
COPY systemctl.py /usr/bin/systemctl
RUN test -L /bin/systemctl || ln -sf /usr/bin/systemctl /bin/systemctl


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080 10050

ENTRYPOINT ["/entrypoint.sh"]

#!/bin/bash

## start and configure mysql
echo "==> Starting MySQL..."
systemctl start mysql

echo "==> Creating Zabbix database..."
mysql -uroot -ppassword <<SQL
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on *.* to zabbix@localhost identified by 'password';
quit
SQL

echo "==> Import initial schema and data."
 zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -ppassword zabbix

echo "==> Starting Services..."
systemctl start zabbix-server zabbix-agent apache2

if [ "$#" -ne 0 ]; then
	# execute user commands
	$@
else
	# tail logs
	echo "==> Tailing logs..."
	tail -f \
		/var/log/zabbix/*.log \
		/var/log/mysql/*.log \
		/var/log/apache2/error.log
fi

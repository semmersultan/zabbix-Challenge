export APP_NAME=zabbix-test

build:
	@echo "----------------- Build one container for zabbix Server, Database and Web Console"
	@docker build -t $(APP_NAME) .

show:
	@echo "------------------Show the newly build container"
	@docker images | grep $(APP_NAME)

deploy:
	@echo "-----------------compose the new build container"
	@docker-compose up

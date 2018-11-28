export APP_NAME=zabbix-test
db_user := AQICAHgjp8JqMhZ5vNctS3BExPMBqLTQzAZDjF0ZIhGwFC/zBwEMcZI5AmoM7RthJT74+ECPAAAAZTBjBgkqhkiG9w0BBwagVjBUAgEAME8GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMr7xb/uRXUgskTuq7AgEQgCKrcUI5NmP/QbW0heolRfjQdKchoQjhE0O6rENu9PpZiT08
db_pass := AQICAHgjp8JqMhZ5vNctS3BExPMBqLTQzAZDjF0ZIhGwFC/zBwGTDStzxbeEvOUNwvW/3N2xAAAAaTBnBgkqhkiG9w0BBwagWjBYAgEAMFMGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMgHY0L52+GPmda3yOAgEQgCahuPyporI/IIG7YdGSJWu1MHsQ+FIsacyGPgUyYduKeI4Q/3x7WA==

deps:
	@docker-compose build shush_decrypt > /dev/null

test-lint-yaml:
	@echo "----------------- Test Lint YAML"
	@docker-compose run --rm yamllint .
	@docker-compose run --rm yamllint ansible/.

build:
	@echo "----------------- Build one container for zabbix Server, Database and Web Console"
	@docker build -t $(APP_NAME) .

show:
	@echo "------------------Show the newly build container"
	@docker images | grep $(APP_NAME)

deploy:
	@echo "-----------------compose the new build container"
	@docker-compose up \
	-o DatabaseUser=$$(docker-compose run shush_decrypt $(db_user)) \
	-o DatabasePassword=$$(docker-compose run shush_decrypt $(db_pass)) \

add-host:
	@echo "-----------------add host using ansible playbook"
	@ansible-playbook -i ansible/hosts ansible/add-host.yml

export-template:
	@echo "-----------------export template using ansible playbook"
	@ansible-playbook -i ansible/hosts ansible/export-template.yml

.PHONY: up

CERT_DIR := app/assets
CERT_FILES := $(CERT_DIR)/server.crt $(CERT_DIR)/server.key

LOG_DIR := log
LOG_FILES := $(LOG_DIR)/development.log $(LOG_DIR)/production.log

up: log
	docker-compose up

log:
	@mkdir $@
	@touch log/development.log log.production.log

cert:
	@mkdir -p app/assets
	@openssl req -x509 -nodes -newkey rsa:4096 -keyout $(CERT_DIR)/server.key -out $(CERT_DIR)/server.crt -days 365 -subj "/C=US/ST=South Carolina/L=Columbia/O=OSSYS/OU=Software Dev & Testing/CN=localhost/emailAddress=andrew.zah@ossys.com" 


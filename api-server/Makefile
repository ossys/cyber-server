.PHONY: cert sockets log up

CERT_DIR := app/assets
CERT_FILES := $(CERT_DIR)/server.crt $(CERT_DIR)/server.key

LOG_FILES := log/development.log log/production.log
SOCKET_FILE := tmp/sockets/puma.sock

up: log cert sockets
	docker-compose up
log: $(LOG_FILES)
cert: $(CERT_FILES)
sockets: $(SOCKET_FILE)

$(LOG_FILES):
	@if [ ! -d "log" ]; then mkdir log; fi
	@touch $@

$(CERT_FILES):
	@if [ ! -d "$(CERT_DIR)" ]; then mkdir $(CERT_DIR); fi
	@openssl req -x509 -nodes -newkey rsa:4096 -keyout $(CERT_DIR)/server.key -out $(CERT_DIR)/server.crt -days 365 -subj "/C=US/ST=South Carolina/L=Columbia/O=OSSYS/OU=Software Dev & Testing/CN=localhost/emailAddress=andrew.zah@ossys.com" 

$(SOCKET_FILE):
	@if [ ! -d "tmp/sockets" ]; then mkdir -p tmp/sockets; fi
	@touch $@

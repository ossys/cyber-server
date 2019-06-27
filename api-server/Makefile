.PHONY: bundle cert creds sockets log up

CRED_FILES := config/credentials.yml.enc config/master.key

CERT_DIR := app/assets
CERT_FILES := $(CERT_DIR)/server.crt $(CERT_DIR)/server.key

LOG_FILES := log/development.log log/production.log
SOCKET_FILE := tmp/sockets/puma.sock

up: bundle log cert creds
	@bundle install
	docker-compose up --build
log: $(LOG_FILES)
cert: $(CERT_FILES)
sockets: $(SOCKET_FILE)
creds: $(CRED_FILES)

bundle:
	@bundle install

$(LOG_FILES):
	@if [ ! -d "log" ]; then mkdir log; fi
	@touch $@

$(CERT_FILES):
	@if [ ! -d "$(CERT_DIR)" ]; then mkdir $(CERT_DIR); fi
	@openssl req -x509 -nodes -newkey rsa:4096 -keyout $(CERT_DIR)/server.key -out $(CERT_DIR)/server.crt -days 365 -subj "/C=US/ST=South Carolina/L=Columbia/O=OSSYS/OU=Software Dev & Testing/CN=localhost/emailAddress=andrew.zah@ossys.com" 

$(CRED_FILES):
	@bundle exec rails credentials:edit

$(SOCKET_FILE):
	@if [ ! -d "tmp/sockets" ]; then mkdir -p tmp/sockets; fi
	@touch $@

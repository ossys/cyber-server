.PHONY: bundle cert creds sockets log up

RAILS_CONFIG_DIR := api-server/config
RAILS_CRED_FILES := $(RAILS_CONFIG_DIR)/credentials.yml.enc $(RAILS_CONFIG_DIR)/master.key

CADDY_CERT_DIR := api-server/app/assets
CADDY_CERT_FILES := $(CADDY_CERT_DIR)/server.crt $(CADDY_CERT_DIR)/server.key

RAILS_LOG_DIR := api-server/log
RAILS_LOG_FILES := $(RAILS_LOG_DIR)/development.log $(RAILS_LOG_DIR)/production.log

RAILS_SOCKETS_DIR := api-server/tmp/sockets
RAILS_SOCKET_FILE := $(SOCKETS_DIR)/puma.sock

up: bundle log cert creds
	docker-compose up --build
log: $(RAILS_LOG_FILES)
cert: $(CADDY_CERT_FILES)
sockets: $(RAILS_SOCKET_FILE)
creds: $(RAILS_CRED_FILES)

bundle:
	@bundle install --gemfile=./api-server/Gemfile

$(RAILS_LOG_FILES):
	@if [ ! -d "$(RAILS_LOG_DIR)" ]; then mkdir $(RAILS_LOG_DIR); fi
	@touch $@

$(CADDY_CERT_FILES):
	@if [ ! -d "$(CADDY_CERT_DIR)" ]; then mkdir $(CADDY_CERT_DIR); fi
	@openssl req -x509 -nodes -newkey rsa:4096 -keyout $(CADDY_CERT_DIR)/server.key -out $(CADDY_CERT_DIR)/server.crt -days 365 -subj "/C=US/ST=South Carolina/L=Columbia/O=OSSYS/OU=Software Dev & Testing/CN=localhost/emailAddress=andrew.zah@ossys.com"

$(RAILS_CRED_FILES):
	@./api-server/bundle exec rails credentials:edit

$(RAILS_SOCKET_FILE):
	@if [ ! -d "$(RAILS_SOCKETS_DIR)" ]; then mkdir -p $(RAILS_SOCKETS_DIR); fi
	@touch $@

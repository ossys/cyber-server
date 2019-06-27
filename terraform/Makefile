.PHONY: linux

OSQUERY_VERSION := 3.3.2
LINUX_HASH := 05b0b15bd44e6a85813dd92a567c371031938aedbcd2e64d32229a3ca0c2d509
LINUX_FILE := vendor/osquery-linux-$(OSQUERY_VERSION).tar.gz

OSX_HASH := 6ac1baa9bd13fcf3bd4c1b20a020479d51e26a8ec81783be7a8692d2c4a9926a
OSX_FILE := vendor/osquery-osx-$(OSQUERY_VERSION).pkg

WINDOWS_HASH := 3dcef980e942dc0c6a0bd389c547cba277d2f04518b48c3ce97cf646621c6f00
WINDOWS_FILE := vendor/osquery-deb-$(OSQUERY_VERSION).amd64.deb

RPM_HASH := c69382f622db68036bb61767f1f456474e86d2ad9bf0e33454b9d5dbb543a37e
RPM_FILE := vendor/osquery-windows-$(OSQUERY_VERSION).msi

DEBIAN_HASH := 6c54a55df1feaf410064bc87696f9829d0787fb5b9c7beabeb4f5cca7ce6c3fb
DEBIAN_FILE := vendor/osquery-rpm-$(OSQUERY_VERSION).x86_64.rpm

linux: $(LINUX_FILE)
osx: $(OSX_FILE)
windows: $(WINDOWS_FILE)
rpm: $(RPM_FILE)
debian: $(DEBIAN_FILE)
all: linux osx windows rpm debian


$(LINUX_FILE):
	curl https://pkg.osquery.io/linux/osquery-$(OSQUERY_VERSION)_1.linux_x86_64.tar.gz -L -o $(LINUX_FILE)
	echo "$(LINUX_HASH) $(LINUX_FILE)" | sha256sum -c

$(OSX_FILE):
	curl https://pkg.osquery.io/darwin/osquery-$(OSQUERY_VERSION).pkg -L -o $(OSX_FILE)
	echo "$(OSX_HASH) $(OSX_FILE)" | sha256sum -c

$(WINDOWS_FILE):
	curl https://pkg.osquery.io/windows/osquery-$(OSQUERY_VERSION).msi -L -o $(WINDOWS_FILE)
	echo "$(WINDOWS_HASH) $(WINDOWS_FILE)" | sha256sum -c

$(RPM_FILE):
	curl https://pkg.osquery.io/rpm/osquery-$(OSQUERY_VERSION)-1.linux.x86_64.rpm -L -o $(RPM_FILE)
	echo "$(RPM_HASH) $(RPM_FILE)" | sha256sum -c

$(DEBIAN_FILE):
	curl https://pkg.osquery.io/deb/osquery_$(OSQUERY_VERSION)_1.linux.amd64.deb -L -o $(DEBIAN_FILE)
	echo "$(DEBIAN_HASH) $(DEBIAN_FILE)" | sha256sum -c

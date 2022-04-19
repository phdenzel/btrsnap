PREFIX ?= /usr/local/bin
SYSTEMD_PREFIX ?= /etc/systemd/system
LOCAL_BIN = ./bin
LOCAL_SERVICE_DIR = ./services

all:
	@echo Run \'[PREFIX=/prefix/path] make install\' to install btrsnap.
	@echo Depending on the PREFIX you might need to use sudo...

install:
	@mkdir -p $(PREFIX)
	@cp btrsnap $(PREFIX)/
	@chmod 755 $(PREFIX)/btrsnap
	@mkdir -p $(LOCAL_BIN)
	@ln -sf $(PREFIX)/btrsnap $(LOCAL_BIN)/btrsnap-"`uuidgen`"

install-service: service-root service-home

service-root:
	cp $(LOCAL_SERVICE_DIR)/btrsnap-root@.service $(SYSTEMD_PREFIX)/
	cp $(LOCAL_SERVICE_DIR)/btrsnap-root@.timer $(SYSTEMD_PREFIX)/

service-home:
	cp $(LOCAL_SERVICE_DIR)/btrsnap-home@.service $(SYSTEMD_PREFIX)/
	cp $(LOCAL_SERVICE_DIR)/btrsnap-home@.timer $(SYSTEMD_PREFIX)/

test:
	SKIP=1 ./test_btrsnap

test-long:
	./test_btrsnap

uninstall:
	rm -f $(PREFIX)/btrsnap
	rm -f `readlink -f $(LOCAL_BIN)/*`
	rm -rf $(LOCAL_BIN)
	rm -rf $(SYSTEMD_PREFIX)/btrsnap-*.service
	rm -rf $(SYSTEMD_PREFIX)/btrsnap-*.timer

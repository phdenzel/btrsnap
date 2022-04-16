PREFIX ?= $(HOME)/local/bin

all:
	@echo Run \'make install\' to install btrsnap.

install:
	@mkdir -p $(PREFIX)
	@cp -p btrsnap $(PREFIX)/
	@chmod 755 $(PREFIX)/btrsnap

test:
	sudo SKIP=1 ./test_btrsnap

test-all:
	sudo ./test_btrsnap

uninstall:
	@rm $(PREFIX)/btrsnap

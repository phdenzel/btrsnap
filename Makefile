PREFIX ?= $(HOME)/local/btrsnap

all:
	@echo Run \'make install\' to install Neofetch.

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(HOME)/local/bin
	@cp -p btrsnap $(DESTDIR)$(PREFIX)/bin/btrsnap
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/btrsnap
	@ln -sf $(DESTDIR)$(PREFIX)/bin/btrsnap $(HOME)/local/bin/btrsnap

test:
	sudo SKIP=1 test_btrsnap

test-all:
	sudo test_btrsnap

clean:
	@rm -rf $(DESTDIR)$(PREFIX)/bin
	@rm $(HOME)/local/bin/btrsnap

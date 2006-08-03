package = nagios-notify
version = 0.9.1
prefix = /usr
sysconfdir = /etc/nagios
sbindir = $(prefix)/sbin
templatedir = $(sysconfdir)/templates

all:

install:
	install -d $(DESTDIR)$(sbindir)
	install nagios-notify $(DESTDIR)$(sbindir)
	install -d $(DESTDIR)$(templatedir)
	cp -a templates/*.tmpl $(DESTDIR)$(templatedir)

dist:
	rm -rf $(package)-$(version)
	svn up
	install -d $(package)-$(version)
	cp -a Makefile nagios-notify templates $(package)-$(version)
	tar --exclude=.svn --exclude='*~' -cjf $(package)-$(version).tar.bz2 $(package)-$(version)
	rm -rf $(package)-$(version)

package = nagios-notify
version = 0.9.5
prefix = /usr
sysconfdir = /etc/nagios
tooldir = $(prefix)/lib/nagios
templatedir = $(sysconfdir)/templates
pluginconfdir = $(sysconfdir)/plugins

all:

install:
	install -d $(DESTDIR)$(tooldir)
	install $(package) $(DESTDIR)$(tooldir)
	install -d $(DESTDIR)$(templatedir)
	cp -a templates/*.tmpl $(DESTDIR)$(templatedir)
	install -d $(DESTDIR)$(pluginconfdir)
	cp -a $(package).cfg $(DESTDIR)$(pluginconfdir)

dist:
	rm -rf $(package)-$(version)
	svn up
	install -d $(package)-$(version)
	cp -a Makefile $(package) $(package).cfg templates $(package)-$(version)
	tar --exclude=.svn --exclude='*~' -cjf $(package)-$(version).tar.bz2 $(package)-$(version)
	rm -rf $(package)-$(version)

package = nagios-notify
version = 0.14
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

ChangeLog:
	./changelog.sh

dist: ChangeLog
	@test -z "`git status --porcelain`" || { echo >&2 'Seems git workspace not clean. Use "git clean -f" to remove unwanted files; aborting'; exit 1; }
	rm -rf $(package)-$(version)
	install -d $(package)-$(version)
	cp -a Makefile ChangeLog $(package) $(package).cfg templates $(package)-$(version)
	tar --exclude='*~' --xz -cf $(package)-$(version).tar.xz $(package)-$(version)
	rm -rf $(package)-$(version)

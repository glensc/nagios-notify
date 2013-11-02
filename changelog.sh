#!/bin/sh
# Run this to generate ChangeLog.

[ -e .git/shallow ] && git fetch --unshallow
git log --format='%+ai [%h] %aN <%ae>%n%n%x09* %s' --stat | sed '1d' > ChangeLog

# obfuscate emails <user@domain> and (user@domain)
sed -i -e 's,\([<(].*\)@\(.*[)>]\),\1/at/\2,g' ChangeLog

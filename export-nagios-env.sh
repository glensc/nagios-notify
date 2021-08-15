#!/bin/sh

echo '#!/bin/sh'
echo 'set -eu'

awk -F= -vc="'" -vq="'\"'\"'" '/NAGIOS_/{
	s = $2;
	for (i=3; i <= NF; i++) {
		s = s "=" $i;
	}
	if (s ~ c) {
		gsub(c, q, s);
	}
	printf("export %s=%s%s%s;\n", $1, c, s, c)
}' "$@"

echo '"$@"'

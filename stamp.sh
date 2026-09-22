#!/bin/sh
# Escribe la marca de despliegue en index.html. Se usa la hora y no el hash
# del commit porque estampar cambia el contenido y, con ello, el propio hash.
set -e
cd "$(dirname "$0")"
STAMP="$(date +'%d %b %Y · %H:%M')"
python3 - "$STAMP" <<'PY'
import re, sys
p = "index.html"
s = open(p, encoding="utf-8").read()
s = re.sub(r'const BUILD = "[^"]*";', 'const BUILD = "%s";' % sys.argv[1], s, count=1)
open(p, "w", encoding="utf-8").write(s)
PY
echo "sello: $STAMP"

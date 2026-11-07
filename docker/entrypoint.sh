#!/bin/sh
set -e

# crée /dev/log et écrit dans /var/log/syslog
rsyslogd

exec "$@"

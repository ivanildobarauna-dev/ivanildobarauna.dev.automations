#!/bin/sh
set -e

# Inicializa o Datadog Tracer antes de tudo
exec node -r /data/tracing.js /usr/local/lib/node_modules/n8n/dist/index.js "$@"

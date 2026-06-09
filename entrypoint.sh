#!/bin/sh
set -e

# File konfigurasi ada di /tmp/app/runtime-config.js
CONFIG_FILE="/tmp/app/runtime-config.js"

# Lakukan substitusi variabel lingkungan
envsubst < "$CONFIG_FILE" > /tmp/runtime-config.tmp
mv /tmp/runtime-config.tmp "$CONFIG_FILE"

# Jalankan Nginx
exec nginx -g 'daemon off;'

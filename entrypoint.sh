#!/bin/sh
set -e

# File konfigurasi sekarang ada di root Nginx yang baru
CONFIG_FILE="/tmp/nginx_root/runtime-config.js"

# Lakukan substitusi
# Kita tidak perlu mv, bisa langsung timpa jika permissions benar
envsubst < "$CONFIG_FILE" > /tmp/runtime-config.tmp
cp /tmp/runtime-config.tmp "$CONFIG_FILE"
rm /tmp/runtime-config.tmp

# Jalankan Nginx
exec nginx -g 'daemon off;'

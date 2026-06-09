#!/bin/sh
set -e

# DEBUG
echo "DEBUG: Checking environment variables for runtime-config.js..."

CONFIG_FILE="/usr/share/nginx/html/runtime-config.js"

# Gunakan envsubst untuk menimpa file
# Kita arahkan output ke file sementara, lalu pindahkan
envsubst < "$CONFIG_FILE" > /tmp/runtime-config.tmp
mv /tmp/runtime-config.tmp "$CONFIG_FILE"

# Verifikasi
echo "Content of runtime-config.js after substitution:"
cat "$CONFIG_FILE"

# Jalankan Nginx
exec nginx -g 'daemon off;'

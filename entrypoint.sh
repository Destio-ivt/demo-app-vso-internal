#!/bin/sh
# Generate runtime-config.js dari environment variables
envsubst < /usr/share/nginx/html/runtime-config.js > /tmp/runtime-config.js
mv /tmp/runtime-config.js /usr/share/nginx/html/runtime-config.js

# Jalankan Nginx
nginx -g 'daemon off;'

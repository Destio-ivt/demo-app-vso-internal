#!/bin/sh
set -e

# Salin file asli ke /tmp agar bisa dimodifikasi
cp /usr/share/nginx/html/runtime-config.js /tmp/runtime-config.js

# Lakukan substitusi pada file di /tmp
envsubst < /tmp/runtime-config.js > /tmp/runtime-config.tmp
mv /tmp/runtime-config.tmp /tmp/runtime-config.js

# Buat symbolic link dari lokasi asli ke file yang sudah dimodifikasi di /tmp
# Jika folder asli read-only, kita mungkin butuh pendekatan lain (misal mengkonfigurasi ulang root Nginx)
# Namun mari coba ini dulu.
ln -sf /tmp/runtime-config.js /usr/share/nginx/html/runtime-config.js

# Verifikasi
echo "Content of /tmp/runtime-config.js after substitution:"
cat /tmp/runtime-config.js

# Jalankan Nginx
exec nginx -g 'daemon off;'

# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginxinc/nginx-unprivileged:alpine

# Buat direktori root Nginx di /tmp agar pasti bisa ditulis
USER root
RUN mkdir -p /tmp/nginx_root && \
    chown -R nginx:nginx /tmp/nginx_root

# Salin hasil build
COPY --from=build /app/dist /tmp/nginx_root

# Konfigurasi Nginx baru
RUN echo 'server { \
    listen 8080; \
    server_name localhost; \
    root /tmp/nginx_root; \
    index index.html; \
    location / { try_files $uri $uri/ /index.html; } \
}' > /etc/nginx/conf.d/default.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# Pastikan user nginx memiliki akses penuh ke direktori ini
RUN chown -R nginx:nginx /tmp/nginx_root && \
    chown nginx:nginx /entrypoint.sh

USER nginx

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]

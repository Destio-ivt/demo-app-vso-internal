# Build stage (Tetap gunakan dist karena Vite/React modern biasanya menghasilkan folder /dist)
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginxinc/nginx-unprivileged:alpine

# Salin konten ke /tmp/app dan set permissions
USER root
RUN mkdir -p /tmp/app && \
    cp -r /app/dist/* /tmp/app/ && \
    chown -R nginx:nginx /tmp/app

# Buat file konfigurasi Nginx yang baru agar root mengarah ke /tmp/app
RUN echo 'server { \
    listen 8080; \
    server_name localhost; \
    root /tmp/app; \
    index index.html; \
    location / { try_files $uri $uri/ /index.html; } \
}' > /etc/nginx/conf.d/default.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER nginx

# Ekspos ke port 8080 (Aman untuk OpenShift non-root)
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]

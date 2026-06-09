# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginxinc/nginx-unprivileged:alpine

# Salin konten dari stage 'build' ke direktori yang bisa ditulis (/tmp/app)
USER root
COPY --from=build /app/dist /tmp/app
RUN chown -R nginx:nginx /tmp/app

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

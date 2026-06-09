# Build stage (Tetap gunakan dist karena Vite/React modern biasanya menghasilkan folder /dist)
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage (Ganti ke unprivileged)
FROM nginxinc/nginx-unprivileged:alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Ekspos ke port 8080 (Aman untuk OpenShift non-root)
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
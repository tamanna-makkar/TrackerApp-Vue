# Stage 1 - Builder
# Uses Node.js to install dependencies and build the Vue app
FROM node:23.11.1-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* /app/

RUN npm install

COPY . /app

RUN npm run build

# Stage 2 - Runner
# Copies only the built dist/ folder into a clean nginx image
# No Node.js, no npm, no source code — just static files served by nginx
FROM nginx:alpine

# Upgrade Alpine packages to get patched versions of libcrypto3 and libssl3
RUN apk upgrade --no-cache

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

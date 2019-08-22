FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.17.3-alpine
COPY --from=builder /app/dist/angular /usr/share/nginx/html

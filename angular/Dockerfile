FROM node:alpine as build
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=build /app/dist/angular /usr/share/nginx/html

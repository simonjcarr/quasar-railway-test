# develop stage
FROM node:18-alpine as develop-stage
WORKDIR /app
COPY package*.json /app
RUN npm install
RUN npm install -g @quasar/cli
COPY . /app/
# build stage
FROM develop-stage as build-stage
ENV PORT=80
RUN quasar build
# production stage
FROM nginx:1.17.5-alpine as production-stage
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

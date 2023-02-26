
############ Build Stage ############

FROM node:18-alpine as builder

WORKDIR /app

ADD . /app

RUN npm install

RUN npm install -g @quasar/cli

RUN quasar build

############ Serve Stage ############

FROM caddy:alpine

COPY --from=builder /app/dist/spa /srv

COPY Caddyfile /etc/caddy/Caddyfile

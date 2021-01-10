# Dockerfile
FROM node:14.15.1-alpine

# create destination directory
WORKDIR /app

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

ENV APP_ROOT /app

WORKDIR ${APP_ROOT}
COPY . ${APP_ROOT}

RUN npm ci
RUN npm run build

ENV HOST 0.0.0.0

# Specify a basee image
FROM node:14.15.1-alpine

WORKDIR '/app'

COPY ./package.json .

RUN npm install

COPY . .

CMD ["npm", "run", "dev"]

ENV HOST 0.0.0.0
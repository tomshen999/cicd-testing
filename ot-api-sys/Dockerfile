FROM node:20.13.1-alpine3.18
# FROM --platform=linux/amd64 node:20.8.1-alpine3.18
WORKDIR /app
# USER root

RUN npm install -g @nestjs/cli

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

EXPOSE 5050

# VOLUME /vol/web/media
# VOLUME /vol/web/static

CMD npm config set prefer-offline true && \
    # npx wait-port ot-pg-write:5432 && \
    # npx wait-port ot-pg-read:5432 && \
    npm run start

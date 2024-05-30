FROM node:20.13.1-alpine3.18
# FROM --platform=linux/amd64 node:20.8.1-alpine3.18
WORKDIR /app
# RUN npm install -g nodemon
# RUN npm install -g @nestjs/cli
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 5051
CMD npm config set prefer-offline true && \
    # npx wait-port ot-pg-write:5432 && \
    # npx wait-port ot-pg-read:5432 && \
    npm run start:dev

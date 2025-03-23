FROM node:18

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install

COPY server ./server
COPY db ./db
COPY openapi.yaml ./
COPY postman_collection.json ./

RUN apt-get update && apt-get install -y sqlite3
RUN sqlite3 db/database.sqlite < db/seed.sql

EXPOSE 3000
CMD ["npm", "start"]

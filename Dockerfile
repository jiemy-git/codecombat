FROM node:22.22.1

WORKDIR /coco
RUN apt-get update && \
    apt-get install -y git python3 make g++ && \
    apt-get clean
RUN npm install -g bower
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

EXPOSE 3000

CMD ["node", "index.js"]

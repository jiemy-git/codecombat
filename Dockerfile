FROM node:14-bullseye

RUN apt-get update && apt-get install -y python3 build-essential libssl-dev

WORKDIR /app

COPY package*.json ./
RUN rm -f package-lock.json \
    && npm install -g npm@7.24.2 \
    && npm config set registry https://registry.npmjs.org/ \
    && npm install --ignore-engines --legacy-peer-deps

COPY . .

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]

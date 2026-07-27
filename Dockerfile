FROM node:10.24.1

# 修复 Debian 9 源
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update && apt-get install -y python build-essential libssl-dev

WORKDIR /app

COPY package*.json ./
RUN rm -f package-lock.json \
    && npm install -g npm@6.14.17 \
    && npm config set registry https://registry.npmjs.org/ \
    && npm install --ignore-engines --no-optional

COPY . .

ENV NODE_OPTIONS="--max-old-space-size=4096"
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]

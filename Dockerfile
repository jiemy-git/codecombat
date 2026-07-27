FROM node:10.24.1

# 修复 Debian 9 归档源
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i '/stretch-updates/d' /etc/apt/sources.list

RUN apt-get update && apt-get install -y python build-essential

WORKDIR /app

COPY package*.json ./
RUN rm -f package-lock.json
RUN npm install --registry=https://registry.npmmirror.com --ignore-engines

COPY . .
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]

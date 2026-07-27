<<<<<<< HEAD
FROM node:22.22.1

WORKDIR /coco
RUN apt-get update && \
    apt-get install -y git python3 make g++ && \
    apt-get clean
RUN npm install -g bower
COPY package*.json ./
RUN npm install
=======
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

>>>>>>> d8f84c22555b828a99fd2a7dcc83c83777d09fd0
COPY . .
RUN npm run build

EXPOSE 3000
<<<<<<< HEAD

CMD ["node", "index.js"]
=======
CMD ["npm", "start"]
>>>>>>> d8f84c22555b828a99fd2a7dcc83c83777d09fd0

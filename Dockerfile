FROM eclipse-temurin:17 as ApiBuilder

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN mkdir /app

WORKDIR /app
RUN git clone -b 1.5 https://github.com/PlayEdu/PlayEdu.git playedu

# 编译jar包
WORKDIR /app/playedu

RUN /app/playedu/mvnw -Dmaven.test.skip=true clean package

FROM node:20-alpine as NodeBuilder

# install git - apt-get replace with apk
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash git openssh

# 编译后端
WORKDIR /app
RUN git clone -b 1.5 https://github.com/PlayEdu/backend.git backend
RUN git clone -b 1.5 https://github.com/PlayEdu/frontend.git pc
RUN git clone -b 1.5 https://github.com/PlayEdu/h5.git h5

# 编译后台
WORKDIR /app/backend
RUN npm i && VITE_APP_URL=/api/ npm run build

# 编译PC
WORKDIR /app/pc
RUN npm i && VITE_APP_URL=/api/ npm run build

# 编译H5
WORKDIR /app/h5
RUN npm i && VITE_APP_URL=/api/ npm run build

FROM eclipse-temurin:17

LABEL maintainer="0xtyz <tengyongzhi@meedu.vip>"

# 使用东八区时间环境
RUN echo "Asia/Shanghai" > /etc/timezone

#安装基本组件
RUN apt update && apt install -y nginx

RUN mkdir /app

COPY docker/start.sh /app/api/start.sh

COPY --from=ApiBuilder /app/playedu/playedu-api/target/playedu-api.jar /app/api/app.jar

COPY --from=NodeBuilder /app/backend/dist /app/backend
COPY --from=NodeBuilder /app/pc/dist /app/frontend
COPY --from=NodeBuilder /app/h5/dist /app/h5

# 复制nginx配置文件
COPY docker/nginx/conf/nginx.conf /etc/nginx/sites-enabled/default

RUN chmod +x /app/api/start.sh

WORKDIR /app/api

ENTRYPOINT ["/app/api/start.sh"]
## PlayEdu Light Docker 构建方案

本套方案将 API + PC 前台 + H5 前台 + 后台管理 四个整合在一个镜像当中，适用于轻量级客户。

### 直接运行

在命令行中执行：

```
docker run -d -p 9700:80 -p 9800:9800 -p 9801:9801 -p 9900:9900 --name playedu-light \
  -e DB_HOST=数据库host \
  -e DB_PORT=数据库端口 \
  -e DB_NAME=数据库名 \
  -e DB_USER=数据库用户 \
  -e DB_PASS=数据库密码 \
  -e REDIS_HOST=Redis的host \
  -e REDIS_PORT=Redis的端口 \
  -e REDIS_PASS=redis的密码 \
  registry.cn-hangzhou.aliyuncs.com/playedu/light:1.3
```

跑起来之后，可以通过下面的链接访问前后台：

| 端口         | 地址                       |
| ------------ | -------------------------- |
| API 服务     | `http://你的服务器IP:9700` |
| 学员 PC 界面 | `http://你的服务器IP:9800` |
| 学员 H5 界面 | `http://你的服务器IP:9801` |
| 后台管理     | `http://你的服务器IP:9900` |

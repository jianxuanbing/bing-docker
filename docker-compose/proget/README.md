# 安装指南
## 在Linux服务器上安装
ProGet 可以用过 Docker 在 Linux 服务器上运行。
推荐的容器资源是：
- 最低环境要求：2C2G
- 推荐的中等环境要求：2C4G
- 推荐的大型环境要求：4C8G

> 存储空间至少要保留10G以上的空间用来存储包和容器镜像

## 环境变量
- `PROGET_DATABASE`：数据库连接字符串。
- `PROGET_DB_TYPE`：数据库类型，默认：`PostgreSQL`。

## 账号
默认账号密码：Admin

# 注意事项
- 需要注意赋予 `volumes` 访问权限。
> chmod 777 -R /data/proget

# 初始化
## 下载 Docker 离线包
下载地址：[https://download.docker.com/linux/static/stable/x86_64/](https://download.docker.com/linux/static/stable/x86_64/)
例如：[docker-20.10.5.tgz](https://download.docker.com/linux/static/stable/x86_64/docker-20.10.5.tgz)

## 下载 docker-compose 离线包
下载地址：[https://github.com/docker/compose/releases](https://github.com/docker/compose/releases)
例如：[docker-compose-linux-x86_64](https://github.com/docker/compose/releases/download/v2.12.0/docker-compose-linux-x86_64)

# 安装操作
将下载的包，放入当前的目录下，然后执行下面的命令：
```
sh auto-install-docker.sh [docker-版本号.tgz]
# 例如：
sh auto-install-docker.sh docker-20.10.5.tgz
```
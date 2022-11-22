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

# 二进制安装命令补全
## Docker 命令补全
docker 命令补全地址：https://raw.githubusercontent.com/docker/cli/[版本号]/contrib/completion/bash/docker
- 当前分支版本：https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker
- 20.10.5 版本：https://raw.githubusercontent.com/docker/cli/v20.10.5/contrib/completion/bash/docker

## Docker-Compose 命令补全
docker-compose 命令补全地址：https://raw.githubusercontent.com/docker/compose/[版本号]/contrib/completion/bash/docker-compose
- 当前分支版本：https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose
- 1.28.6 版本：https://raw.githubusercontent.com/docker/compose/1.28.6/contrib/completion/bash/docker-compose

## 参考链接
- [404 at command-line bash completion script](https://github.com/docker/docs/issues/14617)
- [how-to-add-bash-command-completion-for-docker-on-mac-os-x](https://stackoverflow.com/questions/26132451/how-to-add-bash-command-completion-for-docker-on-mac-os-x)
- [enable-docker-command-completion](https://www.techrepublic.com/article/enable-docker-command-completion/)
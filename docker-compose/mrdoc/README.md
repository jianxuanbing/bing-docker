# 使用文档
## docker版本PDF配置说明
### 执行chrome相关模块安装
```
# 安装chrome和chromedriver
---
# 官方源下载安装
docker exec -it mrdoc apk add chromium chromium-chromedriver
# 三方源下载安装(下载慢的尝试用这个)
docker exec -it mrdoc apk add chromium chromium-chromedriver --repository http://mirrors.ustc.edu.cn/alpine/v3.14/main/ --allow-untrusted
# 检查chrome是否安装成功
docker exec -it mrdoc chromium-browser --version
# 如果chrome无法运行，则需要执行以下命令
docker exec -it mrdoc apk upgrade -a
---
# 重启容器,使配置生效
docker restart mrdoc
```
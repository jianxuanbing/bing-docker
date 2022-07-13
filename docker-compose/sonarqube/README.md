# 说明
默认账号密码为：`admin`,`admin`

# 异常
## ES异常
### 问题
`max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]`

### 解决方案
#### 临时方案
在宿主机中执行
```
sysctl -w vm.max_map_count=262144
sysctl -a|grep vm.max_map_count
```

#### 持久化方案
修改/etc/sysctl.conf文件，在最后一行添加:
```
vm.max_map_count=262144
```
立即生效则执行：
```
/sbin/sysctl -p
```

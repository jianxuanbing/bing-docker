#!/bin/bash
docker exec spug init_spug admin 123456
docker restart spug
# 必须LF格式命令，否则存在密码初始化问题
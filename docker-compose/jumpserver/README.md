# Jumpserver 堡垒机

## 1. 环境变量
### 1.1 基础信息
- `SECRET_KEY`：保护签名数据的密钥，首次安装请一定要修改并记牢，后续升级和迁移不可更改，否则将导致加密的数据不可解密。
- `BOOTSTRAP_TOKEN`：为组件认证使用的密钥，仅组件注册时使用。组件指 `koko`、`guacamole`。

### 1.2 数据库（MySQL）
- `DB_HOST`：数据库IP地址。
- `DB_PORT`：数据库端口号。
- `DB_USER`：数据库用户名。
- `DB_PASSWORD`：数据库密码。
- `DB_NAME`：数据库名称。

### 1.3 缓存（Redis）
- `REDIS_HOST`：Redis的IP地址。
- `REDIS_PORT`：Redis的端口号。
- `REDIS_PASSWORD`：Redis的密码。
# 服务端
## 环境变量
- `DRONE_SERVER_HOST`: 服务器访问地址（必填）。用于提供外部用的主机名或IP地址，如果使用IP地址，则可以包含端口号。
- `DRONE_SERVER_PROTO`: 外部访问协议（必填）。用于提供访问协议，该值应设置为`http`或`https`。
- `DRONE_RPC_SECRET`: RPC访问密钥（必填）。用于提供代理客户端访问用。

# 客户端
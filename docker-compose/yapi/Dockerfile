######## 构建 ########
FROM node:12.16.3-alpine3.11 as builder

# 安装构建工具
RUN apk add --update --no-cache ca-certificates curl wget cmake build-base git bash python make gcc g++ zlib-dev autoconf automake file nasm \
  && update-ca-certificates

# YAPI 版本
ENV YAPI_VERSION=1.12.0

# 拉取 YAPI 源码 git clone --branch "v1.12.0" --single-branch --depth 1 https://gitee.com/mirrors/YApi.git
RUN mkdir /yapi && cd /yapi \
    && git clone \
    --branch "v${YAPI_VERSION}" \
    --single-branch \
    --depth 1 \
    https://gitee.com/mirrors/YApi.git vendors

# 安装依赖
RUN cd /yapi/vendors \
    # && rm package-lock.json \
    && npm install --production --registry https://registry.npm.taobao.org
    # && yarn

######## 镜像 ########
FROM node:12.16.3-alpine3.11

LABEL MAINTAINER = 'jianxaunbing(https://github.com/jianxuanbing)'

ENV TZ="Asia/Shanghai" HOME="/"

WORKDIR ${HOME}

COPY --from=builder /yapi/vendors /api/vendors

COPY --from=builder /yapi/vendors/config_example.json /api/config.json

COPY docker-entrypoint.sh /api/

EXPOSE 3000

RUN chmod 755 /api/docker-entrypoint.sh

ENTRYPOINT ["/api/docker-entrypoint.sh"]
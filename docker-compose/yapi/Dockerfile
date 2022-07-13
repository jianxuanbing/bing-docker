FROM alpine:latest as builder
ENV YAPI_VERSION=1.9.1
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update \
    && apk add --no-cache git nodejs npm  bash vim  python python-dev gcc libcurl make \
    && rm -rf /var/cache/apk/* \
    && mkdir /yapi && cd /yapi && git clone -b "v${YAPI_VERSION}" --single-branch --depth 1 https://gitee.com/mirrors/YApi.git vendors \
    && npm install -g node-gyp yapi-cli npm@latest --registry https://registry.npm.taobao.org \
    && cd /yapi/vendors && npm i --production --registry https://registry.npm.taobao.org

FROM node:11-alpine
LABEL MAINTAINER = 'jianxaunbing(https://github.com/jianxuanbing)'
ENV TZ="Asia/Shanghai" HOME="/"
WORKDIR ${HOME}

COPY --from=builder /yapi/vendors /api/vendors
COPY config.json /api/
EXPOSE 3000
COPY docker-entrypoint.sh /api/
RUN chmod 755 /api/docker-entrypoint.sh
ENTRYPOINT ["/api/docker-entrypoint.sh"]
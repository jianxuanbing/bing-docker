#!/bin/bash
docker stop mrdoc && docker rm mrdoc
docker pull jonnyan404/mrdoc-nginx
docker-compose up -d
# 迁移数据库
docker exec -it mrdoc python manage.py makemigrations
docker exec -it mrdoc python manage.py migrate
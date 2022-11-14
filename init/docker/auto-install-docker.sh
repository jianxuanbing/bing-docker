#!bin/sh
usage(){
    echo "Usage: $0 FILE_NAME_DOCKER_TAR_GZ"
    echo "       $0 docker-20.10.5.tgz"
    echo "Get docker binary from: https://download.docker.com/linux/static/stable/x86_64/"
    echo "eg: wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.5.tgz"
    echo ""
}

SYSTEMDDIR=/etc/systemd/system/
SERVICEFILE=docker.service
DOCKERDIR=/usr/bin
DOCKERBIN=docker
SERVICENAME=docker

# Must run as root
if [[ $(id -u) -ne 0 ]]; then echo "Please run as root"; exit 1; fi
# 禁用 SELinux - 需要重启
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux && cat /etc/sysconfig/selinux

if [ $# -ne 1 ]; then
    usage
    exit 1
else
    FILETARGZ="$1"
fi

if [ ! -f ${FILETARGZ} ]; then
    echo "Docker binary tgz files does not exist, please check it"
    echo "Get docker binary from: https://download.docker.com/linux/static/stable/x86_64/"
    echo "eg: wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.5.tgz"
    exit 1
fi

# 解压tar包
echo "##unzip : tar xvpf ${FILETARGZ}"
tar xvpf ${FILETARGZ}
echo

# 将docker目录移动到/usr/bin目录下
echo "##binary : ${DOCKERBIN} copy to ${DOCKERDIR}"
cp -p ${DOCKERBIN}/* ${DOCKERDIR} >/dev/null 2>&1
which ${DOCKERBIN}

# 将docker.service 移动到/etc/systemd/system/目录
echo "##systemd service: ${SERVICEFILE}"
echo "##docer.service: create docker systemd file"
cat >${SYSTEMDDIR}/${SERVICEFILE} <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
# the default is not to use systemd for cgroups because the delegate issues still
# exists and systemd currently does not support the cgroup feature set required
# for containers run by docker
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
# Having non-zero Limit*s causes performance problems due to accounting overhead
# in the kernel. We recommend using cgroups to do container-local accounting.
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
# Uncomment TasksMax if your systemd version supports it.
# Only systemd 226 and above support this version.
#TasksMax=infinity
TimeoutStartSec=0
# set delegate yes so that systemd does not reset the cgroups of docker containers
Delegate=yes
# kill only the docker process, not all processes in the cgroup
KillMode=process
# restart the docker process if it exits prematurely
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
EOF

echo ""

# 添加文件权限
echo '添加文件权限...'
chmod +x ${SYSTEMDDIR}/${SERVICEFILE}

echo "create daemon.json"
if [ ! -d "/etc/docker" ]; then
    mkdir /etc/docker
fi
cat >/etc/docker/daemon.json <<EOF
{
    "hosts": [
        "unix:///var/run/docker.sock",
        "tcp://0.0.0.0:12375"
    ],
    "registry-mirrors": [
        "https://dockerproxy.com",
	    "https://docker.mirrors.ustc.edu.cn",
	    "https://hub-mirror.c.163.com"
    ],
    "insecure-registries": [
        "nexus.u-localhost.com:8096",
        "docker.u-localhost.com"
    ],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "1g",
        "max-file": "5"
    }
}
EOF

echo ""

echo "##Service reload: ${SERVICENAME}"
systemctl daemon-reload

echo "##Service status: ${SERVICENAME}"
systemctl status ${SERVICENAME}

echo "##Service restart: ${SERVICENAME}"
systemctl restart ${SERVICENAME}

echo "##Service status: ${SERVICENAME}"
systemctl status ${SERVICENAME}

echo "##Service enabled: ${SERVICENAME}"
systemctl enable ${SERVICENAME}

echo '## docker version'
docker version

echo '将docker-compose复制到/usr/local/bin目录下...'
cp ./docker-compose-Linux-x86_64 /usr/local/bin/docker-compose

echo '添加文件权限...'
chmod +x /usr/local/bin/docker-compose

echo 'docker-compose安装成功...'
docker-compose --version

echo '创建docker用户组'
groupadd docker

if [ $(id -u) != "0" ]; then
    echo '将登陆用户加入到docker用户组中'
    gpasswd -a centos docker
    # gpasswd -a $USER docker
    echo '更新用户组'
    newgrp docker
    echo '查看是否添加成功'
    cat /etc/group | grep ^docker

    # 解决 sudo docker-compse 命令找不到的问题
    echo '创建docker-compose 符号链接'
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi
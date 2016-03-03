安装依赖程序
yum install  autoconf libtool openssl-devel gcc -y
yum groupinstall "Development Tools"

下载ss源码
yum install  git -y
git clone https://github.com/madeye/shadowsocks-libev.git

编译ss
cd shadowsocks-libev
./configure
make && make install

创建json文件
vim /etc/config.json
     {
    "server":"47.89.45.168",
    "server_port":7777,
    "password":"niutendo",
    "timeout":60,
    "method":"rc4-md5"
     }

启动服务
ss-server -c  /etc/config.json -f /tmp/ss.pid

验证
ps -ef |grep ss
ss -tnlp|grep  7777

HAproxy
global
ulimit-n 51200
defaults
log global
mode tcp
option dontlognull
contimeout 1000
clitimeout 150000
srvtimeout 150000
frontend ss-in
bind *:7777
default_backend ss-out
backend ss-out
server server1 47.89.45.168:7777 maxconn 20480

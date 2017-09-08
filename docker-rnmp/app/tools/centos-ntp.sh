#!/bin/bash
yum install -y ntpdate
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yes | cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate us.pool.ntp.org
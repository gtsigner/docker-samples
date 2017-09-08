#!/bin/bash
docker run --rm -v /etc/localtime:/data/localtime centos cp /usr/share/zoneinfo/Asia/Shanghai /data/localtime

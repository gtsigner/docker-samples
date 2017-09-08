## Overview 
docker 的开发环境和线上生产环境

### Containers
-   1.nginx
-   2.mysql-db
-   3.redis-db
-   4.php-fpm
-   5.composer
-   6.bower
-   7.visualizer

其中不需要的镜像可以注释掉

## QuickStart



### Install Docker
安装Docker Ce
```bash
$bash ./app/tools/docker-installer.sh
```
### Install docker-compose
```bash
$cp ./docker-compose /usr/local/bin/
$chmod +x /usr/lcoal/bin/docker-compose
```
## Usage

默认启动方式,这种方式适用于本地测试开发环境，暴漏了数据库端口redis端口方便调试
1.docker-compose up --build

部署环境
2.


### backup data
导入默认的测试数据
```base
$docker-compose -f db-backup.yml up 
```


### restore data 
还原default备份数据
```bash
$docker-compose -f db-restore.yml up
```

### 启动构建项目依耐工具
```bash
$docker-compose -f docker-build.yml up
```


## Future
1. project-cli 生成架构工具

2. 集群部署

3. gitlab gitlab-runner 实现CI CD





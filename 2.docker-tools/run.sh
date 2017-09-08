#!/usr/bin/env bash

##直接命令Cli

alias php7-cli="docker run -it --rm -v \$PWD:/app --workdir=/app php:7.1-cli php"
alias php56-cli="docker run -it --rm -v \$PWD:/app --workdir=/app php:5.6-cli php"
alias go="docker run -it --rm -v \$PWD:/app --workdir=/app golang:1.9.0-stretch go"

##包管理器，做缓存
alias composer="docker run -it --rm -v \$PWD:/app --workdir=/app composer"

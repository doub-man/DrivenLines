#!/usr/bin/env bash

echo 'Setup Script Just For Mac & Debian series Development Env'

function touch_file()
{
  if [ ! -f $1  ]; then
    cp $2 $1
  fi
}

touch_file ./config/redis.yml ./config/redis.yml.example
touch_file ./config/database.yml ./config/database.yml.example
touch_file ./config/cable.yml ./config/cable.yml.example
touch_file ./config/secrets.yml ./config/secrets.yml.example

function try_install()
{
  if $1 == "homebrew"; then
    echo 'now install homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    brew install $1
  fi
}

set -e

if [ `uname` == "Darwin" ]; then
  echo 'now starting auto config in mac'

  which brew || try_install homebrew
  which postgres || try_install postgresql
  which redis-server || try_install redis
  which elasticsearch || try_install elasticsearch
else
  if [ "x$USER" != "xroot" ]; then
    exec sudo ./$0 "$@"
  fi
  apt-get install imagemagick
  apt-get install postgresql
  apt-get install redis
  # 暂时没有Ubuntu环境 Production环境的话我建议是全部源码手动配置
fi

bundle

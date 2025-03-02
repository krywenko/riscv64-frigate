#!/usr/bin/env bash
set -e

if ! [ $(command -v "git") ]; then
  echo "=> Gee Git"
  exit 127
fi


export NVM_DIR="/usr/local/nvm"

echo "=> Git clone nvm"
 git clone https://gitee.com/RubyMetric/nvm-official "$NVM_DIR"
#cd "$NVM_DIR"
#git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))


 chown -R $(whoami):$(whoami) /usr/local/nvm
 chmod -R 775 /usr/local/nvm


echo "=>  NVM "
echo 'export NVM_DIR="/usr/local/nvm"' |  tee -a /etc/profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' |  tee -a /etc/profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' |  tee -a /etc/profile


echo "=> mirror"
echo "export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node" |  tee -a /etc/profile

echo "=>  nvm-update"
wget -O nvm-update.sh https://gitee.com/RubyMetric/nvm-cn/raw/main/nvm-update.sh
chmod +x ./nvm-update.sh
 mv ./nvm-update.sh /usr/local/bin/nvm-update

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "=> test NVM ！"


nvm --version
echo "=> install node ！"

NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release nvm install 20.16.0
node -v

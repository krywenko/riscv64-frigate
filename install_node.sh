#!/usr/bin/env bash
set -e

if ! [ $(command -v "git") ]; then
  echo "=> 正在安装 Git"
  exit 127
fi

# 设置 NVM 安装路径
export NVM_DIR="/usr/local/nvm"

echo "=> Git clone nvm"
 git clone https://gitee.com/RubyMetric/nvm-official "$NVM_DIR"
#cd "$NVM_DIR"
#git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))

# 修改 NVM 目录权限，确保可用
 chown -R $(whoami):$(whoami) /usr/local/nvm
 chmod -R 775 /usr/local/nvm

# 添加全局环境变量（适用于所有用户）
echo "=> 配置 NVM 全局环境变量"
echo 'export NVM_DIR="/usr/local/nvm"' |  tee -a /etc/profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' |  tee -a /etc/profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' |  tee -a /etc/profile

# 配置淘宝镜像
echo "=> 使用淘宝镜像"
echo "export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node" |  tee -a /etc/profile

# 下载 nvm-update
echo "=> 安装 nvm-update"
wget -O nvm-update.sh https://gitee.com/RubyMetric/nvm-cn/raw/main/nvm-update.sh
chmod +x ./nvm-update.sh
 mv ./nvm-update.sh /usr/local/bin/nvm-update

# 让 NVM 立即生效（仅对当前会话）
export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "=> 安装完成! NVM 已在当前终端生效，无需重启终端！"

# 测试 NVM 是否生效
nvm --version
NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release nvm install 20.16.0
node -v

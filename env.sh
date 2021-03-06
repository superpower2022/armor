#!/bin/bash
#
# 自瞄代码环境配置工具
# 需要 Ubuntu 16.04，18.04 或 20.04 环境
# 有待进一步优化
#
# @author: frezcirno
#

START_DIR=`dirname $0`
START_DIR=`cd $START_DIR; pwd`
USER_ID=`id -u`

if [[ "$USER_ID" != "0" ]]; then
	echo "ERROR: You need to run the script as superuser (root account)."
	exit 1
fi

# echo -n "是否要更换 Ubuntu 镜像源至 mirrors.tuna.tsinghua.edu.cn [Y/n]? "
# read ANSWER
# if [ "$ANSWER" = "Y" -o "$ANSWER" = "y" -o "$ANSWER" = "" ]; then
# sed -e "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" \
# -e "s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" \
# -e "s/cn.mirrors.tuna.tsinghua.edu.cn/mirrors.tuna.tsinghua.edu.cn/g" \
# -i /etc/apt/sources.list
# apt update
# fi

echo "Installing packages......."
apt install -y build-essential cmake git vim libgtk2.0-dev libboost-dev libboost-thread-dev libusb-1.0-0-dev catkin lsb linux-headers-generic libdlib-dev libopencv-dev
# ncnn
apt install -y build-essential git cmake libprotobuf-dev protobuf-compiler libvulkan-dev vulkan-utils libopencv-dev


echo ""
echo -n "是否要安装vscode [Y/n]? "
read ANSWER
if [ "$ANSWER" = "Y" -o "$ANSWER" = "y" -o "$ANSWER" = "" ]; then
    # 从官网下载安装vscode
    wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O /tmp/install-vscode
    dpkg -i /tmp/install-vscode
    rm /tmp/install-vscode
fi

echo ""
echo -n "是否要安装相机SDK [Y/n]? "
read ANSWER
if [ "$ANSWER" = "Y" -o "$ANSWER" = "y" -o "$ANSWER" = "" ]; then
    echo "Installing Camera SDK......."
    mkdir -p sdk/mindvision
    tar xzf sdk/linuxSDK_V2.1.0.12.tar.gz  -C sdk/mindvision
fi

echo ""
echo -n "是否要安装 Serial 库 [Y/n]? "
read ANSWER
if [ "$ANSWER" = "Y" -o "$ANSWER" = "y" -o "$ANSWER" = "" ]; then
    echo "Downloading serial......."
    rm -rf /tmp/serial
    git clone --depth 1 -b v1.0.1 https://e.coding.net/tj-robomaster/armor/serial.git /tmp/serial

    echo "Installing serial......."
    mkdir -p /tmp/serial/build
    pushd /tmp/serial/build >>/dev/null
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
    make install
    popd >>/dev/null
fi

echo "OK"

#!/usr/bin/env bash

yum -y update
touch /.rootfs-repartition
systemctl reboot
yum -y install yum-utils
yum -y groupinstall development
yum -y install bash-completion
yum -y install lvm2* dosfstools bsdtar
yum -y install tmux vim wget

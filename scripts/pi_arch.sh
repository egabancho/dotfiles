#!/usr/bin/env bash

su -

passwd

# Initialize the pacman keyring
pacman-key --init
# Populate the Arch Linux ARM package signing keys
pacman-key --populate archlinuxarm

pacman -Syu

rm /etc/localtime
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
timedatectl set-ntp true

pacman -S --noconfirm sudo
pacman -S --noconfirm base-devel
pacman -S --noconfirm htop tigervnc python
pacman -S --noconfirm xfce4
pacman -S --noconfirm xorg xorg-xinit xorg-server xterm
pacman -S --noconfirm alsa-utils alsa-firmware alsa-lib alsa-plugins
pacman -S --noconfirm vim neovim python-neovim
pacman -S --noconfirm  emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
pacman -S --noconfirm tmux git hub bash-completion
pacman -S --noconfirm docker
systemctl start docker.service
systemctl enable docker.service

useradd -m -G wheel, docker -s /bin/bash egabancho
passwd egabancho

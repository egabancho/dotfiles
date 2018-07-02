#!/usr/bin/env bash

su -

# Initialize the pacman keyring
pacman-key --init
# Populate the Arch Linux ARM package signing keys
pacman-key --populate archlinuxarmpacman-key --populate archlinuxarm

pacman -Syu

rm /etc/localtime
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
timedatectl set-ntp true

pacman -Sy sudo
pacman -S xorg xorg-server
pacman -S xterm make
pacman -Sy vim neovim python-neovim
curl -sLf https://spacevim.org/install.sh | bash
pacman -S emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
pacman -S tmux git hub bash-completion
pacman -S docker
systemctl start docker.service
systemctl enable docker.service
# gpasswd -a egabancho docker

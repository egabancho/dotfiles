#!/usr/bin/env bash

sudo -i

# Create a directory that won't get nuked during DSM security updates
mkdir /volume1/@optware
cd /volume1/@optware

feed=http://ipkg.nslu2-linux.org/feeds/optware/syno-i686/cross/stable/
ipkg_name=ipkg-opt_0.99.163-10_i686.ipk
wget $feed/$ipkg_name
tar -xOvzf $ipkg_name ./data.tar.gz | tar -C / -xzvf -
mkdir -p /opt/etc/ipkg
echo "src cross $feed" > /opt/etc/ipkg/feeds.conf

# Move the extracted /opt files to our persistent optware directory & symlink /opt
mv /opt/* /volume1/@optware/
rm -r /opt
ln -s /volume1/@optware /opt

# Make ipkg available immediately to root
export PATH=/opt/sbin:/opt/bin:$PATH

# Create a service script to recreate the symlink to persistent optware directory if needed at reboot
mkdir -p /usr/local/etc/rc.d/
wget -O /usr/local/etc/rc.d/optware.sh https://raw.githubusercontent.com/egabancho/dotfiles/master/files/optware.sh
https://gist.githubusercontent.com/stevenhaddox/cead26111aea3fdcc9a5/raw/optware.sh
chmod 755 /usr/local/etc/rc.d/optware.sh

ipkg update
ipkg install sudo
# visudo
# %administrators ALL=(ALL) ALL
ipkg install git
ipkg install tmux
ipkg install vim
ipkg install lsblk

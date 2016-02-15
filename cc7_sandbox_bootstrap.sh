# Create the VM
# openstack server create --key-name lxplus --flavor m1.medium --image "CC7 Extra - x86_64 [2016-02-09]" <user>-sandbox

# Install some nice defaults
yum groupinstall "Development Tools" -y
yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel wget htop curl-devel xdg-utils -y
yum install vim-enhanced -y

# git
wget https://github.com/git/git/archive/v2.7.1.tar.gz -O git.tar.gz
tar -zxf git.tar.gz
cd git-*
make configure
./configure --prefix=/usr/local
make install
git --version

# tmux
yum install ncurses-devel
wget https://sourceforge.net/projects/levent/files/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz

tar -xzf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure --prefix=/usr/local
make
make install
wget https://github.com/tmux/tmux/releases/download/2.1/tmux-2.1.tar.gz

tar -xzf tmux-2.1.tar.gz
cd tmux-2.1
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
make install
tmux -V

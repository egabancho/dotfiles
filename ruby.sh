#!/usr/bin/env bash

# Install ruby-build and rbenv
# https://gorails.com/setup/osx/10.11-el-capitan
brew install rbenv ruby-build

EXTRA_PATH=~/.extra
# Create the file if it doesn't exists (-a to change only access time)
touch -a $EXTRA_PATH

if ! grep -q rbenv $EXTRA_PATH; then
    cat <<'EOF' >> $EXTRA_PATH # Use simple quotes around EOF to print " as is
#########################################################
# Added by egabancho/dotfiles/scripts/ruby_bootstrap.sh #
#########################################################

# Add rbenv to bash so that it loads every time you open a terminal
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
EOF
fi
source $EXTRA_PATH

# Install ruby
rbenv install 2.5.1
rbenv global 2.5.1
ruby -v

# Nice REPL
gem install pry

# Optional gems
gem install rails -v 5.2.0

rbenv rehash

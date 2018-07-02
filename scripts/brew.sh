#!/usr/bin/env bash

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Bash 4.
brew install bash
brew install bash-completion
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Python!
brew install python
brew install python3

# Base stuff

# Install `wget` with IRI support.
brew install wget --with-iri
# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`
brew install findutils --with-default-names
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

brew install tmux
brew install git git-extras ghi hub

# Editors
brew install emacs-plus --with-mailutils --with-no-titlebar
brew tap d12frosted/emacs-plus
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew tap caskroom/fonts && brew cask install font-source-code-pro
brew install vim
curl https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim --create-dirs -o ~/.vim/colors/solarized.vim

# Linux tools and handy utils
# https://github.com/brona/iproute2mac
brew install iproute2mac
brew install ispell
brew install ag ack
brew install colordiff
brew install tree
# File converter
brew install pandoc
# Network utils
brew install nmap

brew cleanup

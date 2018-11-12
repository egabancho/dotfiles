#!/usr/bin/env bash

# Check for Homebrew, Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macos ... suck).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install Bash 4.
brew install bash
brew install bash-completion@2

# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  # Prompts for password
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  # Change to the new shell, prompts for password
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install cooler editors that the system ones.
brew install vim --with-override-system-vi
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-mailutils --HEAD
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew install neovim

# Install fonts.
brew tap caskroom/fonts
brew cask install font-source-code-pro

# Install other useful binaries.
brew install openssh
brew install tmux
brew install git git-extras ghi hub
brew install ispell
brew install ag ack
brew install colordiff
brew install tree
# Show system information on the terminal
brew install neofetch
# Better man pages for lazy people
brew install tldr
# Move things to trash instead of directly rm
brew install trash
# Top for humans
brew install htop
# Command-line fuzzy finder.
brew install fzf
# Cat clone with wings.
brew install bat
# JSON processor.
brew install jq
# HTTP client.
brew install httpie
# Swiss Army Knife for macOS.
brew install m-cli
# Get the password of the WiFi you're on.
brew install wifi-password
# A simple, fast and user-friendly alternative to 'find'
brew install fd

# Remove outdated versions from the cellar.
brew cleanup

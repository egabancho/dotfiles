#!/usr/bin/env bash

# Stop on errors
set -e

echo "Checking if Xcode Command Line tools are installed...";

# Checks if path to command line tools exist
# Credit: https://apple.stackexchange.com/questions/219507/best-way-to-check-in-bash-if-command-line-tools-are-installed
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
  test -d "${xpath}" && test -x "${xpath}" ; then
  echo "Xcode Command Line tools are already installed ..."; echo;
else
  echo "Installing Xcode Command Line Tools ..."; echo;
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose;
  # https://developer.apple.com/documentation/xcode_release_notes/xcode_10_release_notes
  sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
fi

echo "Checking if Homebrew is already installed..."; 

# Checks if Homebrew is installed
# Credit: https://gist.github.com/codeinthehole/26b37efa67041e1307db
if test ! $(which brew); then
  echo "Installing Homebrew ...";
  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
else
  echo "Homebrew is already installed...";
fi

echo "Updating and upgrading Homebrew ..."; echo;
yes | brew update &> /dev/null
yes | brew upgrade &> /dev/null

# Checking if pyenv is installed
if ! command -v pyenv >/dev/null; then
  echo "Installing pyenv ...";
  brew install pyenv;
  eval "$(pyenv init -)"
fi

# Install a nicer python version
eval "$(pyenv init -)"
if pyenv versions | grep -q "3.7.0"; then
  pyenv install -f 3.7.0
fi
pyenv shell 3.7.0

rm -rf .venv
echo "Creating python virtual environment in ./.venv/ folder..."; echo;
python -m venv .venv

echo "Activating virtual environment..."; echo;
source .venv/bin/activate

echo "Installing requirements..."; echo;
pip install -r requirements.txt

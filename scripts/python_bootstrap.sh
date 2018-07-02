#!/usr/bin/env bash

# Install Python
brew install python@2 python
brew link python --overwrite

# Install virtual environments globally
pip2 install virtualenv virtualenvwrapper
pip3 install virtualenv virtualenvwrapper


EXTRA_PATH=~/.extra
# Create the file if it doesn't exists (-a to change only access time)
touch -a $EXTRA_PATH

if ! grep -q python_bootstrap $EXTRA_PATH; then
    cat <<EOF >> $EXTRA_PATH
###########################################################
# Added by egabancho/dotfiles/scripts/python_bootstrap.sh #
###########################################################

# Add new homebrew python2 to the PATH as python
# Add pipsi ~/.local/bin to the PATH
export PATH="/usr/local/opt/python/libexec/bin:~/.local/bin:$PATH"
# Set venv directory inside Developer folder
export WORKON_HOME=~/Developer/venvs
# Use python 3 by default
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# Source virtualenvwrapper, added by python_bootstrap.sh"
source /usr/local/bin/virtualenvwrapper_lazy.sh
EOF
fi

source $EXTRA_PATH

# use pipsi
curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
pipsi install ipython --python python2
pipsi install cookiecutter --python python2
pipsi install isort --python python2
pipsi install pygments --python python2
pipsi install autoflake --python python2
pipsi install flake8 --python python2
pipsi install hy --python python2
pipsi install yapf --python python2
pipsi install fabric --python python2
# pipsi install aws

# This are libraries, no binaries
pip install importmagic
pip install epc

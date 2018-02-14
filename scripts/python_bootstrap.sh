#!/usr/bin/env bash

# Install Python
brew install python python3

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
pipsi install ipython
pipsi install cookiecutter
pipsi install isort
pipsi install pygments
pipsi install autoflake
pipsi install flake8
pipsi install hy
pipsi install yapf
pipsi install fabric

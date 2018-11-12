#!/usr/bin/env bash

# Install Python

brew install pyenv
pyenv init
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
pyenv install 3.7.0
pyenv global 3.7.0


EXTRA_PATH=~/.extra
# Create the file if it doesn't exists (-a to change only access time)
touch -a $EXTRA_PATH

if ! grep -q python_bootstrap $EXTRA_PATH; then
    cat <<EOF >> $EXTRA_PATH
###########################################################
# Added by egabancho/dotfiles/scripts/python_bootstrap.sh #
###########################################################

# Add pipsi ~/.local/bin to the PATH
export PATH="$HOME/.local/bin:$PATH"

# Set venv directory inside Developer folder
export WORKON_HOME=$HOME/Developer/venvs

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
fi

source $EXTRA_PATH

# Install some executables as local venvs
pip_isolated cookiecutter isort hy yapf pygments autoflake flake8

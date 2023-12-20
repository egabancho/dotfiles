#!/usr/bin/env bash

# Make vscode the default editor.
if [ -z "$SSH_CONNECTION" ]; then
    export EDITOR=vim;
else
    export EDITOR=$(type -P vim || type -P vi)
fi
export VISUAL="code --wait"

export SSH_KEY_PATH=$HOME/.ssh/id_rsa.pub

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY_FILE=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Require pip to run inside a virtual enviroment
export PIP_REQUIRE_VIRTUALENV=true

# Pipenv (ignore some warnings)
export PIPENV_VERBOSITY=-1

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Pager
export PAGER="less -FX"
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -FX';

# Make gpg always happy
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

# Bat color theme
export BAT_THEME='TwoDark'

# Add local bin to the path
export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts
# psql is a keg-only formula
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

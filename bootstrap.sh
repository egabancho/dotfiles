set -e

command -v brew 2>&1 > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/opt/homebrew/bin/brew bundle
stow .

command -v nvm 2>&1 > /dev/null || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

command -v uv 2>&1 > /dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh
command -v ruff 2>&1 > /dev/null || curl -LsSf https://astral.sh/ruff/install.sh | sh
command -v black 2>&1 > /dev/null || uv tool install black
command -v ansible-lint 2>&1 > /dev/null || uv tool install ansible-lint
command -v pipenv  2>&1 > /dev/null || uv tool install pipenv
command -v invenio-cli 2>&1 > /dev/null || uv tool install invenio-cli

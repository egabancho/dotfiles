#!/usr/bin/env bash

brew install node
# brew install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

npm install -g vue-language-server
npm -g install js-beautify

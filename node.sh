#!/usr/bin/env bash

# brew install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install 7.4

npm install -g vue-language-server
npm -g install js-beautify

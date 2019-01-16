#!/usr/bin/env bash

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for file in .{aliases,bash_logout,bash_profile,bash_prompt,bashrc,exports,functions,gitconfig,gitignore_global,inputrc,spacemacs,tmux.conf,tmux.remote.conf,vimrc,wgetrc,liquidpromptrc}; do
    [ -r $CWD/$file ] && [ -f $CWD/$file ] && ln -vfs $CWD/$file $HOME/$file;
done;

mkdir -p $HOME/.config/karabiner
ln -vfa $CWD/karabiner.json $HOME/.config/karabiner/karabiner.json

mkdir -p $HOME/.local/bin
for file in $(ls $CWD/bin/); do
    ln -vfs $CWD/bin/"$file" $HOME/.local/bin/$file;
done
unset file;

# iCloud Drive
# TODO: only for macos
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs/org $HOME/org
ln -s ~/Library/Mobile\ Documents/com~apple~CloudDocs iCLoud\ $HOME/iCloud\ Drive

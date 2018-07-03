#!/usr/bin/env bash

for file in .{aliases,bash_logout,bash_profile,bashrc,exports,functions,gitconfig,gitignore_global,inputrc,spacemacs,tmux.conf,tmux.remote.conf,wgetrc}; do
    [ -r "$file" ] && [ -f "$file" ] && ln -fs $DOTFILES_HOME/"$file" $HOME/$file;
done;
unset file;


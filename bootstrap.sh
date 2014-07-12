#!/usr/bin/env bash

set -o nounset
set -o errexit

__ScriptVersion="0.1"

cd $(dirname ${BASH_SOURCE})
force=false
backup=false
branch='osx'
files=$(find . -maxdepth 1             \
               -not -name \.           \
               -not -name LICENSE      \
               -not -name README.md    \
               -not -name bootstrap.sh \
               -not -name \.git        \
               -not -name \.gitignore  \
               -not -name \.gitmodules \
        | sed 's#.*/##')

function backUp() {
    echo 'BackUp previous dotfiles'
    for file in $files
    do
        echo "Checkin file: $file"
        if [[ -L ~/"$file" ]]; then
            echo "Found symlink for file: $file -> $(readlink ~/$file)"
            echo "Unlinking $file (no backup)"
            unlink ~/$file
        elif [[ -e ~/"$file" ]]; then
            echo "Found $file in your home directory, backing up to $file.bak"
            mv ~/$file ~/$file\.bak
        fi;
    done
}

function install() {
    echo 'Installing'
    # Maybe one day we want simply to run rsync instead
    # rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    #       --exclude "README.md" --exclude "LICENSE" -avh --no-perms . ~
    for file in $files
    do
        echo "Symlinking $file"
        ln -s $(dirname ${BASH_SOURCE})/$file ~/$file
    done
    source ~/.bash_profile
}

function usage () {
    echo "Usage :  $0 [-b -f -g git_branch]

Bootstrap scrip for eGabancho's dotfiles, it creates symlinks in your home
folder to all the files inside the script directory.

Options:
    -b|backup     Back ups the previous content of the present dotfiles to
                *.bak files.
    -g|git branch Branch from the git repository to deploy.
                  Git Branch -> OS
    -v|version    Display script version
  "
}

while getopts ":hvbgf" opt
do
  case $opt in

    h|help         ) usage; exit 0 ;;
    b|backup       ) backup=true; break ;;
    f|force        ) force=true; break ;;
    g|gitbranch    ) branch=$2; break;;
    v|version      ) echo "$0 -- Version $__ScriptVersion"; exit 0   ;;
    \?             ) echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac
done
shift $(($OPTIND-1))

git checkout $branch
git pull origin $branch

echo "Dotfiles available: $files" | tr "\\n" " ,"
echo ""

if [[ $backup == true ]]; then
    backUp
fi

if [[ $force == true || $backup == true ]]; then
    install
else
    read -p "This may overwrite existing files in your home directory.\
             Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install
    fi
fi

unset backUp
unset install
unset usage

echo "Bye!"

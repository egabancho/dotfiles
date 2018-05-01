# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

for file in /etc/bash_completion.d/{yum,git,pip,yum-utils.bash} ; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /etc/bash_completion.d/git ]; then
    complete -o default -o nospace -F _git g;
fi

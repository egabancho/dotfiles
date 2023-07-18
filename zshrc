eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

# Aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.aliases-local ] && source $HOME/.aliases-local
# Functions
[ -f $HOME/.functions ] && source $HOME/.functions

# asdf
[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ] && source /opt/homebrew/opt/asdf/libexec/asdf.sh
# direvn
eval "$(direnv hook zsh)"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
DISABLE_MAGIC_FUNCTIONS=true

# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# preload git completions for usage in aliases
_git 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/egabancho/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

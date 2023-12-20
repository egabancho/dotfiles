eval "$(brew shellenv)"
eval "$(starship init zsh)"

# Aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.aliases-local ] && source $HOME/.aliases-local
# Functions
[ -f $HOME/.functions ] && source $HOME/.functions

# asdf
[ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ] && source "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
# direvn
eval "$(direnv hook zsh)"

# turn on autocompletion
autoload -Uz compinit && compinit

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

bindkey -e

# Delete not working for some reason
bindkey  "^[[3~"  delete-char

# Move word by word using Atl + left/right
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Completion based on history using arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# preload git completions for usage in aliases
_git 2>/dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# GCP stuff
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# psql is a keg-only formula
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"
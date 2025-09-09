# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
 # zsh-autocomplete
)

source $ZSH/oh-my-zsh.sh

# --- SETTINGS ---
#export HISTCONTROL=ignoredups

# --- Prompt ---
# go to $HOME/.config/starship.toml
eval "$(starship init zsh)"

# Vim-style fzf history widget
fzf_history_widget() {
  BUFFER=$(history | tac | awk '{$1="";$1="";if(!seen[$0]++) print$0}' | uniq |  fzf)
  CURSOR=${#BUFFER}
  zle reset-prompt
}

# Register widget
zle -N fzf_history_widget

# Bind keys
bindkey '^H' fzf_history_widget   # Ctrl-H opens history search
bindkey '^Y' autosuggest-accept

# --- Aliases ---
alias vim="nvim"
alias chnvi="~/Linuxscripts/chnvi"

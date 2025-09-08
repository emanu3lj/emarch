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

# --- Prompt ---
# go to $HOME/.config/starship.toml
eval "$(starship init zsh)"

# Vim-style fzf history widget
fzf_history_widget() {
  BUFFER=$(history 1 | awk '{$1=""; print substr($0,2)}' | fzf --no-sort --bind "ctrl-n:down,ctrl-p:up,ctrl-y:accept" --height 40% --reverse)
  CURSOR=${#BUFFER}
  zle reset-prompt
}
# Register widget
zle -N fzf_history_widget

# Bind keys
bindkey '^H' fzf_history_widget   # Ctrl-H opens histor
bindkey '^Y' autosuggest-accept

# --- Aliases ---
alias vim="nvim"
alias chnvi="~/Linuxscripts/chnvi"

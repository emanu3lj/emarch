#!/bin/bash

#source ./shell/zsh.sh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM_PLUGIN="$HOME/.oh-my-zsh/custom"

echo $ZSH_CUSTOM_PLUGIN

rm $ZSH_CUSTOM_PLUGIN/plugins -rf

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM_PLUGIN/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM_PLUGIN/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM_PLUGIN/plugins/fast-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM_PLUGIN/plugins/zsh-autocomplete

# https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df

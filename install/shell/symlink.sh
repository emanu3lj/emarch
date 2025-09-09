#!/bin/bash

set -e

# .zshrc
[ -f $HOME/.zshrc ] && rm $HOME/.zshrc
ln -s $HOME/emarch/dotfiles/.zshrc $HOME/.zshrc

# nvim
[ -d $HOME/.config/nvim/ ] && rm $HOME/.config/nvim -fr
ln -s $HOME/emarch/dotfiles/nvim $HOME/.config/nvim

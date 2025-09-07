#!/bin/bash

set -e
echo "Install: ZSH"

sudo pacman -S --noconfirm zsh-autosuggestions zsh-syntax-highlighting zsh

# Get the path to fish
ZSH_PATH=$(which zsh)

# Add zsh to /etc/shells if it's not already there
if ! grep -q "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

# Change the default shell for the current user
chsh -s "$ZSH_PATH"

echo "ZSH shell installed and set as default. Please log out and log back in to use it."

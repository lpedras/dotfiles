#!/bin/bash
set -e

DOTFILES_DIR=$HOME/.dotfiles

# Check for apt package manager 
if [ "$(command -v apt)" ]; then
  INSTALL_COMMAND="apt install"
fi

# Check for pacman package manager
if [ "$(command -v pacman)" ]; then
  INSTALL_COMMAND="pacman -S --noconfirm" 
fi

# Install Git
if ! [ -x "$(command -v git)" ]; then
  sudo $INSTALL_COMMAND git 
fi

# Clone dotfiles git repository
if ! [[ -d "$DOTFILES_DIR/.git" ]]; then
  git clone git@github.com:lpedras/dotfiles-manjaro.git $DOTFILES_DIR
fi

# Execute dotfiles
$DOTFILES_DIR/bin/dotfiles


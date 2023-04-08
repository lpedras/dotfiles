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
  git clone https://github.com/lpedras/dotfiles.git $DOTFILES_DIR

  git -C $DOTFILES_DIR remote set-url origin git@github.com:lpedras/dotfiles.git
fi

# Execute dotfiles
$DOTFILES_DIR/bin/dotfiles


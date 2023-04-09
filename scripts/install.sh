#!/bin/bash
set -e

DOTFILES_DIR=$HOME/.dotfiles

# Check for apt package manager 
if [ -x "$(command -v apt)" ]; then
 INSTALL_COMMAND="apt install"
 echo "using package manager -> apt"
fi

# Check for pacman package manager
if [ -x "$(command -v pacman)" ]; then
  INSTALL_COMMAND="pacman -S --noconfirm" 
  echo "using package manager -> pacman" 
fi

# Check for detected package manager
if ! [ "$INSTALL_COMMAND" ]; then
  echo "Package manager not found"
  exit
fi

# Install Git
if ! [ -x "$(command -v git)" ]; then
  sudo $INSTALL_COMMAND git 
fi

# Clone dotfiles git repository
if ! [[ -d "$DOTFILES_DIR/.git" ]]; then
  git clone https://github.com/lpedras/dotfiles.git $DOTFILES_DIR
fi

# Execute dotfiles
$DOTFILES_DIR/bin/dotfiles

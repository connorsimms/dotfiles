#!/bin/zsh

export DOTFILES="$HOME/.dotfiles"

brew bundle install --file="$DOTFILES/macos/Brewfile"

zsh "$DOTFILES/macos/link.sh"

if ! grep -q "shellenv" ~/.config/zsh/.zprofile; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.config/zsh/.zprofile
fi

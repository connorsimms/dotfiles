#!/bin/bash

DOTFILES="$HOME/.dotfiles"

symlink() {
    local source="$1"
    local target="$2"

    if [ ! -e "$source" ]; then
        echo "[ERROR] Source config not found: $source"
        return
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ "$(readlink "$target")" == "$source" ]; then
            echo "[SKIPPING] Already linked: $target"
            return
        fi

        rm -rf "$target"
    fi

    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "[LINKED] $target -> $source"
}

symlink "$DOTFILES/hypr"    "$HOME/.config/hypr"
symlink "$DOTFILES/kitty"   "$HOME/.config/kitty"
symlink "$DOTFILES/nvim"    "$HOME/.config/nvim"
symlink "$DOTFILES/tmux"    "$HOME/.config/tmux"
symlink "$DOTFILES/vim"     "$HOME/.config/vim"

symlink "$DOTFILES/zsh/zshenv"   "$HOME/.zshenv"
mkdir -p "$HOME/.config/zsh"
symlink "$DOTFILES/zsh/zshrc"   "$HOME/.config/zsh/.zshrc"




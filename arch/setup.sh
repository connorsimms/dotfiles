#!/bin/bash
set -e

# assumes internet connection exists and pacman installed

echo "Updating system..."
sudo pacman -Syu --noconfirm

install_group() {
    echo "Installing $1..."
    shift
    sudo pacman -S --needed --noconfirm "$@"
}

# base-devel: gcc, make, sudo, etc.
# man-db: ensures manual pages are indexed
install_group "Core Build Tools" \
    base-devel \
    git \
    cmake \
    clang \
    python \
    man-db

install_group "Drivers" \
    nvidia-open \
    pipewire-pulse \
    pipewire-alsa

install_group "Hyprland & Desktop" \
    hyprland \
    dunst \
    xdg-desktop-portal-hyprland \
    hyprpolkitagent \
    qt5-wayland \
    qt6-wayland \
    ttf-0xproto-nerd \
    capitaine-cursors \
    ly \
    rofi \
    hyprpaper \
    cliphist \

install_group "CLI Tools" \
    github-cli \
    vim \
    neovim \
    tmux \
    zsh \
    gdb \
    perf \
    tldr \
    ripgrep \
    tree \
    unzip \
    rsync

install_group "Apps" \
    kitty

# -------------------------------------------------------------------------
# Services
# -------------------------------------------------------------------------

echo "Enabling Services..."

sudo systemctl enable ly@tty2.service
sudo systemctl disable getty@tty2.service

echo "Setup Complete!"

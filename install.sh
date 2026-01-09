#!/bin/bash

OS="$(uname -s)"
echo "OS: $OS"

export DOTFILES="$HOME/.dotfiles"

if [ "$OS" == "Darwin" ]; then

    if ! command xcode-select -p &> /dev/null; then
        xcode-select --install
        echo "Press [Enter] to continue once Xcode finishes. "
        read
    fi

    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew update

    if ! command -v git &> /dev/null; then
        brew install git
    fi

    if [ -d "$DOTFILES" ]; then
        git -C "$DOTFILES" pull origin main || echo "Git pull failed"
    else
        git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"
    fi

	echo "Running macOS setup..."
	zsh "$DOTFILES/macos/setup.sh"

elif [ "$OS" == "Linux" ]; then
	echo "Running Arch Linux setup..."

	if ! command -v git &> /dev/null; then
		echo "Git not found. Installing with pacman..."
		sudo pacman -S git --noconfirm
	fi

    if [ -d "$DOTFILES" ]; then
        git -C "$DOTFILES" pull origin main || echo "Git pull failed"
    else
        git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"
    fi
	
	echo "Installing packages..."
	bash "$DOTFILES/arch/setup.sh"

	echo "Configuring settings..."
	bash "$DOTFILES/arch/link.sh"
fi

echo "Installation complete."

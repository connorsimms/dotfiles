#!/bin/bash

OS="$(uname -s)"
echo "OS: $OS"

if [ -d "$HOME/.dotfiles" ]; then
	echo "~/.dotfiles already exists"
	exit 1
else
	mkdir "$HOME/.dotfiles"
fi

DOTFILES="$HOME/.dotfiles"

if [ $OS" == "Darwin" ]; then
	echo "Running macOS setup..."

	if ! command -v brew &> /dev/null; then
		echo "Homebrew not found. Installing..."
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh	
	fi

	if ! command -v git &> /dev/null; then
		echo "Git not found. Installing with Homebrew..."
		brew install git
	fi

	echo "Cloning dotfiles..."
	git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"

	echo "Installing packages..."	
	source "$DOTFILES/macos/setup.sh"

	echo "Configuring settings..."
	source "$DOTFILES/macos/link.sh"

elif [ "$OS" == "Linux" ]
	echo "Running Arch Linux setup..."

	if ! command -v git &> /dev/null; then
		echo "Git not found. Installing with pacman..."
		pacman -S git --noconfirm
	fi
	
	echo "Cloning dotfiles..."
	git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"

	echo "Installing packages..."
	source "$DOTFILES/arch/setup.sh"

	echo "Configuring settings..."
	source "$DOTFILES/arch/link.sh"
fi

echo "Installation complete."

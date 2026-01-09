#!/bin/bash

OS="$(uname -s)"
echo "OS: $OS"

if [ -d "$HOME/.dotfiles" ]; then
	echo "~.dotfiles already exists"
	exit 1
fi

export DOTFILES="$HOME/.dotfiles"

if [ "$OS" == "Darwin" ]; then
	echo "Running macOS setup..."

	if ! command -v brew &> /dev/null; then
		echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        eval "$(/opt/homebrew/bin/brew/shellenv)"
	fi

	if ! command -v git &> /dev/null; then
		echo "Git not found. Installing with Homebrew..."
		brew install git
	fi

	echo "Cloning dotfiles..."
	git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"

	echo "Installing packages..."	
	bash "$DOTFILES/macos/setup.sh"

	echo "Configuring settings..."
	bash "$DOTFILES/macos/link.sh"

elif [ "$OS" == "Linux" ]; then
	echo "Running Arch Linux setup..."

	if ! command -v git &> /dev/null; then
		echo "Git not found. Installing with pacman..."
		sudo pacman -S git --noconfirm
	fi
	
	echo "Cloning dotfiles..."
	git clone https://github.com/connorsimms/dotfiles.git "$DOTFILES"

	echo "Installing packages..."
	bash "$DOTFILES/arch/setup.sh"

	echo "Configuring settings..."
	bash "$DOTFILES/arch/link.sh"
fi

echo "Installation complete."

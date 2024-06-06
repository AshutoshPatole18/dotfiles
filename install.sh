#!/bin/bash

# Script to auto setup dot files

export PKG_MGR=""

check_root() {
	if [[ "$EUID" -ne 0 ]]; then
		echo "Error: This script requires root privileges. Please run it with sudo."
		exit 1
	fi
}

detect_package_manager() {
	if command -v yum &>/dev/null; then
		# CentOS/RHEL
		export PKG_MGR="yum"
	elif command -v apt-get &>/dev/null; then
		# Debian/Ubuntu
		export PKG_MGR="apt-get"
	else
		echo "Error: Unsupported Linux distribution."
		exit 1
	fi
}

source_rc() {
	if [ -n "$BASH_VERSION" ]; then
		source ~/.bashrc
	elif [ -n "$ZSH_VERSION" ]; then
		source ~/.zshrc
	else
		echo "Unknown shell"
	fi
}

install_node_js() {
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source_rc
 	nvm install 20.10.0
	nvm use 20.10.0
}

function install_prerequisites() {

	detect_package_manager

	if [[ "$PKG_MGR" == "yum" ]]; then
		sudo "$PKG_MGR" install git jq golang -y
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	elif [[ "$PKG_MGR" == "apt-get" ]]; then
		sudo "$PKG_MGR" install git jq golang -y
	fi
}

copy_rc_files(){
  if [[ -r zshrc ]]; then
    cp zshrc ~/.zshrc
  fi
}

install_neovim() {
	# Download Neovim app image
	# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	#
	# # Move the downloaded file to /usr/local/bin as nvim
	# chmod +x nvim.appimage
	# mv nvim.appimage /usr/local/bin/nvim
	#
  sudo $PKG_MGR install -y neovim python3-neovim
	echo "Neovim setup complete. You can now use 'nvim' or 'vi' to open Neovim."
}

install_ohmyzsh() {
	sudo $PKG_MGR install zsh -y

  rm -rf "$HOME/.oh-my-zsh/"
	# Install Oh My Zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
	echo "Oh My Zsh installed successfully. Please restart your terminal to apply changes."
  mv ~/.zshrc ~/.zshrc_old
  copy_rc_files
}

main() {
	check_root
	install_prerequisites
	install_neovim
	install_node_js
  install_ohmyzsh
}

# entry point call
main

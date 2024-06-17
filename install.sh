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
		sudo "$PKG_MGR" install git jq golang bat btop  -y
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	elif [[ "$PKG_MGR" == "apt-get" ]]; then
		sudo "$PKG_MGR" install git jq golang bat btop -y
	fi

  # install gdu
  curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
  chmod +x gdu_linux_amd64
  sudo mv gdu_linux_amd64 /usr/bin/gdu
}

copy_rc_files(){
  if [[ -r zshrc ]]; then
    cp ./.zshrc ~/.zshrc
    cp ./.p10k.zsh ~/.p10k.zsh
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

install_zsh() {
	sudo $PKG_MGR install zsh -y

  mv ~/.zshrc ~/.zshrc_old
  copy_rc_files
  sudo chsh -s /usr/bin/zsh
}

post_installation_steps(){

  # go lsp
  go install golang.org/x/tools/gopls@latest

  # bash lsp
  npm i -g bash-language-server
}

main() {
	check_root
	install_prerequisites
	install_neovim
	install_node_js
  install_zsh
  post_installation_steps
}

# entry point call
main

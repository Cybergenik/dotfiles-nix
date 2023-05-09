#!/bin/zsh

set -eo pipefail

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" && PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Disable prompt
touch "${HOME}/.hushlogin"

function clone() {
	url=$1
	dst=$2
	mkdir -p $dst
	pushd $dst >/dev/null
	git init
	if ! git config remote.origin.url &>/dev/null; then
		git remote add origin $url
	fi
	git fetch origin master
	git reset --hard origin/master
	popd >/dev/null
}

# Setup
mkdir -p "${HOME}/.config"
clone git@github.com:Cybergenik/dotfiles-nix "${HOME}/.config/dotfiles/"

# Z-Shell
clone https://github.com/romkatv/powerlevel10k.git "${HOME}/.config/dotfiles/zsh/powerlevel10k/"
clone https://github.com/zsh-users/zsh-autosuggestions.git "${HOME}/.config/dotfiles/zsh/zsh-autosuggestions/"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.config/dotfiles/zsh/zsh-syntax-highlighting/"
clone https://github.com/chisui/zsh-nix-shell.git "${HOME}/.config/dotfiles/zsh/zsh-nix-shell/"
ln -fsv "${HOME}/.config/dotfiles/zsh/zshrc" "${HOME}/.zshrc"
ln -fsv "${HOME}/.config/dotfiles/zsh/p10k" "${HOME}/.p10k.zsh"

# Neovim
clone git@github.com:Cybergenik/neovim_configs.git "${HOME}/.config/nvim/"

source "${HOME}/.zshrc"


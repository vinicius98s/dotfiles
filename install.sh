is_debian() {
    if [ -f /etc/debian_version ] && [ ! -f /etc/lsb-release ]; then
        return 0 # true
    else
        return 1 # false
    fi
}

is_installed() {
    if which "$1" >/dev/null 2>&1; then
        return 0 # true
    else
        return 1 # false
    fi
}

echo "Installing required programs..."

install_rcm() {
	if ! is_installed "rcup"; then
		echo "Installing rcm"
		if [ is_debian ]; then
			sudo wget -q https://apt.thoughtbot.com/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
			echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
			sudo apt-get update
			sudo apt-get install rcm -y
		else
			sudo apt update
			sudo apt install rcm -y
		fi
	else
		echo "rcm is already installed"
	fi
}

install_rcm

echo "Copying dotfiles"

rcup \
  -x README.md \
  -x ./assets \
  -x install.sh \
  -f \
  -v
 
install_neovim() {
	if ! is_installed "nvim"; then
		echo "Installing Neovim"
		sudo apt-get install neovim -y
	else
		echo "Neovim is already installed"
	fi
}

install_neovim

install_zsh() {
	if ! which zsh; then
		echo "Installing zsh"
		sudo apt install zsh -y
	else
		echo "zsh is already installed"
	fi
}

install_zsh

update_shell() {
	if [ "$SHELL" = "/usr/bin/zsh" ]; then
		echo "Default shell is zsh"
	else
		echo "Setting default shell to zsh"
		chsh -s $(which zsh)
	fi
}

update_shell

install_zinit() {
	if [ ! -f $HOME/.local/share/zinit/zinit.git ]; then
		echo "Installing Zinit"
		bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	else
		echo "Zinit is already installed"
	fi
}

install_theme() {
	if [ ! -f $ZSH/themes/guezwhoz.zsh-theme ]; then
		echo "Installing zsh theme"
		git clone https://github.com/guesswhozzz/021011.zsh-theme $HOME/021011-tools
		mv $HOME/021011-tools/021011.zsh-theme $ZSH/themes/guezwhoz.zsh-theme
		rm -rf $HOME/021011-tools
	else
		echo "Theme is already installed"
	fi
}

install_theme

install_batcat() {
	if ! is_installed "batcat"; then
		echo "Installing bat"
		sudo apt install bat -y
	else
		echo "bat is already installed"
	fi
}

install_batcat


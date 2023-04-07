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

get_latest_release_version() {
  echo $(curl -s "https://api.github.com/repos/$1/releases/latest" \
  | awk -F=":" -v RS="," '$1~/"tag_name"/ {print}' \
  | sed 's/"tag_name": //g' \
  | sed 's/[^"]*"\([^"]*\)".*/\1/' \
  | xargs echo -n)
  return $?
}

install_rcm() {
	if ! is_installed "rcup"; then
		echo "Installing rcm..."
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

install_neovim() {
	if ! is_installed "nvim"; then
		echo "Installing Neovim..."
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x nvim.appimage
		sudo mv ./nvim.appimage /usr/bin/nvim
		echo "Neovim is installed, please check it's version"
		echo $(nvim -v)
	else
		echo "Neovim is already installed"
	fi
}

install_packer() {
	if [ ! -d $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
		echo "Installing packer..."
		git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
	 else
		 echo "packer is already installed"
	fi
}

install_zsh() {
	if ! which zsh; then
		echo "Installing zsh..."
		sudo apt install zsh -y
	else
		echo "zsh is already installed"
	fi
}

update_shell() {
	if [ "$SHELL" = "/usr/bin/zsh" ]; then
		echo "Default shell is zsh"
	else
		echo "Setting default shell to zsh"
		chsh -s $(which zsh)
	fi
}

install_zinit() {
	if [ ! -d $HOME/.local/share/zinit/zinit.git ]; then
		echo "Installing Zinit..."
		bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	else
		echo "Zinit is already installed"
	fi
}

install_theme() {
	if [ ! -f $ZSH/themes/guezwhoz.zsh-theme ]; then
		echo "Installing zsh theme..."
		git clone https://github.com/guesswhozzz/021011.zsh-theme $HOME/021011-tools
		mv $HOME/021011-tools/021011.zsh-theme $ZSH/themes/guezwhoz.zsh-theme
		rm -rf $HOME/021011-tools
	else
		echo "Zsh theme is already installed"
	fi
}

install_batcat() {
	if ! is_installed "batcat"; then
		echo "Installing bat..."
		sudo apt install bat -y
	else
		echo "bat is already installed"
	fi
}

install_ripgrep() {
	if ! is_installed "rg"; then
		echo "Installing ripgrep..."
		sudo apt-get install ripgrep -y
	else
		echo "ripgrep is already installed"
	fi
}

install_tmux() {
	if ! is_installed "tmux"; then
		echo "Installing tmux..."
		sudo apt install tmux -y
	else
		echo "tmux is already installed"
	fi
}

install_tpm() {
	if [ ! -d $HOME/.tmux/plugins/tpm ]; then
		echo "Installing tpm..."
		git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	else
		echo "tpm is already installed"
	fi
}

install_jetbrains_mono() {
	fonts_dir="$HOME/.local/share/fonts"
	if [ ! -d "$fonts_dir" ]; then
	    echo "Creating fonts directory at $fonts_dir"
	    mkdir -p $fonts_dir
	else
	    echo "Found fonts directory at $fonts_dir"
	fi

	if ! ls $fonts_dir | grep "JetBrains Mono" > /dev/null; then
		font_version=$(get_latest_release_version "ryanoasis/nerd-fonts")
		download_font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$font_version/JetBrainsMono.zip"
		wget -O JetBrainsMono.zip $download_font_url

		if ! is_installed "unzip"; then
			echo "Installing unzip..."
			sudo apt install unzip -y
		fi
		
		unzip JetBrainsMono.zip "*Nerd Font Complete Mono.ttf" -d $fonts_dir
		rm JetBrainsMono.zip

		echo "Running fc-cache..."
		fc-cache -f
	else
		echo "Found JetBrains Mono font at $fonts_dir"
	fi
}

install_build_essential() {
  echo "Installing build-essential..."
  sudo apt install build-essential -y
}

install_asdf() {
  if [ ! -d $HOME/.asdf ]; then
    echo "Installing asdf..."
    asdf_version=$(get_latest_release_version "asdf-vm/asdf")
    echo "asdf version: $asdf_version"
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $asdf_version
  else
    echo "Found asdf folder at $HOME/.asdf"
  fi
}

install_node() {
  if is_installed "asdf" && ! is_installed "node"; then
    echo "Installing Node.js with asdf..."
    sudo apt-get install dirmngr gpg curl gawk -y
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest
  else
    echo "asdf cli is not available, skipping Node.js installation"
    echo "If you already downloaded asdf, please run 'source $HOME/.zshrc' to make it's cli available"
  fi
}

echo "Installing required programs..."

install_rcm

echo "Copying dotfiles..."
rcup -x README.md -x ./assets -x install.sh -f -v

install_build_essential

install_neovim

install_packer

install_zsh

update_shell

install_zinit

install_theme

install_batcat

install_ripgrep

install_tmux

install_tpm

install_jetbrains_mono

install_asdf

install_node


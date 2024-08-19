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

install_curl() {
	if ! is_installed "curl"; then
		echo "Installing curl..."
		sudo apt install curl
	else
		echo "curl is already installed"
	fi
}

install_neovim() {
	if ! is_installed "nvim"; then
		echo "Installing Neovim..."
		sudo apt install libfuse2
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

install_ohmyzsh() {
	if [ ! -d $HOME/.oh-my-zsh ]; then
		echo "Installing Oh my zsh..."
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	else
		echo "Oh my zsh is already installed"
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
	if [ ! -f $ZSH/themes/ultima.zsh-theme ]; then
		echo "Installing zsh theme..."
		git clone https://github.com/egorlem/ultima.zsh-theme $HOME/ultima-shell
		mv $HOME/ultima-shell/ultima.zsh-theme $ZSH/themes/ultima.zsh-theme
		rm -rf $HOME/ultima-shell
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

install_kitty() {
	if ! is_installed "kitty"; then
		echo "Installing kitty..."
		curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

		ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
		cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
		cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
		sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
		sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
	else
		echo "kitty is already installed"
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

	if ! ls $fonts_dir | grep "JetBrains" > /dev/null; then
		font_version=$(get_latest_release_version "ryanoasis/nerd-fonts")
		download_font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/$font_version/JetBrainsMono.zip"
		wget -O JetBrainsMono.zip $download_font_url

		if ! is_installed "unzip"; then
			echo "Installing unzip..."
			sudo apt install unzip -y
		fi
		
		unzip JetBrainsMono.zip "*.ttf" -d $fonts_dir
		rm JetBrainsMono.zip

		echo "Running fc-cache..."
		fc-cache -f
	else
		echo "Found JetBrains Mono font at $fonts_dir"
	fi
}

install_build_essential() {
  if ! apt list | grep "build-essential/" > /dev/null; then
    echo "Installing build-essential..."
    sudo apt install build-essential -y
  else
    echo "build-essential is already installed"
  fi
}

install_mise() {
  if ! is_installed "mise"; then
    echo "Installing mise..."
    curl https://mise.run | sh
    source $HOME/.zshrc
  fi
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
  if is_installed "mise"; then
    if ! is_installed "node"; then
      echo "Installing Node.js with mise..."
      mise use --global node@latest

      if ! is_installed "yarn"; then
        echo "Installing yarn..."
        mise plugin i yarn
        mise use --global yarn@1
      fi
    else
      echo "Node.js is already installed"
    fi
  else
    echo "mise cli is not available, skipping Node.js installation"
    echo "If you already downloaded mise, please run 'source $HOME/.zshrc' to make it's cli available"
  fi
}

install_python() {
  if is_installed "mise"; then
    if ! is_installed "python"; then
      echo "Installing Python with mise..."
      mise use --global python@latest
    else
      echo "Python is already installed"
    fi
  else
    echo "mise cli is not available, skipping Python installation"
    echo "If you already downloaded mise, please run 'source $HOME/.zshrc' to make it's cli available"
  fi
}

install_stylua() {
  if ! is_installed "stylua"; then
		version=$(get_latest_release_version "JohnnyMorganz/StyLua")
    echo $version
    download_url="https://github.com/JohnnyMorganz/StyLua/releases/download/$version/stylua-linux.zip"
    echo $download_url
    curl -LO $download_url
    unzip ./stylua-linux.zip
    sudo mv ./stylua /usr/bin
    rm -f stylua-linux.zip
  else
      echo "stylua is already installed"
  fi
}

install_rcm

echo "Copying dotfiles..."
rcup -x README.md -x ./assets -x install.sh -f

echo "Installing required programs..."
 
install_build_essential
 
install_neovim

install_packer

install_batcat

install_ripgrep

install_tmux

install_tpm

install_jetbrains_mono

install_mise

# install_asdf

install_node

install_python
 
install_stylua
 
install_kitty

install_zsh

install_ohmyzsh

install_zinit

install_theme


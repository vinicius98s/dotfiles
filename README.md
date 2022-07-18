# Dotfiles

## Preview
![Nvim](assets/image.png?raw=true)

## Installation

**All Requirements**

- [rcm](https://github.com/thoughtbot/rcm#installation)
- [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
- [Oh My Zsh!](https://github.com/ohmyzsh/ohmyzsh/wiki#welcome-to-oh-my-zsh)
- [Zinit](https://github.com/zdharma-continuum/zinit#install)
- [Custom font](https://www.nerdfonts.com/font-downloads)
- [Neovim 0.5+](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- [packer.nvim](https://github.com/wbthomason/packer.nvim#quickstart)
- [rg](https://github.com/BurntSushi/ripgrep#installation)
- [tmux](https://github.com/tmux/tmux/wiki/Installing)
- [TPM](https://github.com/tmux-plugins/tpm#installation)
- `build-essential` (Ubuntu)

  ```sh
  sudo apt install build-essential
  ```
### Install:
```
cd ~
git clone https://github.com/vinicius98s/dotfiles.git .dotfiles
cd .dotfiles
sh install.sh
```

## Neovim configurations

`<leader> = Space`

**Requirements**

- [Neovim 0.5+](https://github.com/neovim/neovim)
- [packer.nvim](https://github.com/wbthomason/packer.nvim)
- [rg](https://github.com/BurntSushi/ripgrep)

To install plugins: `:PackerInstall`

Some bindings:

- `Ctrl+P` - Open files
- `Ctrl+F` - Fuzzy finder
- `Ctrl+O` - Open buffers
- `<leader> + w` - Move buffer left
- `<leader> + e` - Move buffer right
- `<leader> + q` - Close buffer

## Tmux

Config is based on [Oh my tmux!](https://github.com/gpakosz/.tmux), so most of shortcuts can be found there.

**Requirements**

- [TPM](https://github.com/tmux-plugins/tpm)

### Zsh

**Requirements**

- [Oh my zsh](https://ohmyz.sh/)

**Themes**

- [guezwhoz](https://github.com/guesswhozzz/021011.zsh-theme)
  `ZSH_THEME="guezwhoz"`
 ```sh
 git clone https://github.com/guesswhozzz/021011.zsh-theme ~/021011-tools
 mv ~/021011-tools/021011.zsh-theme $ZSH/themes/guezwhoz.zsh-theme
 ```

- [Spaceship](https://github.com/spaceship-prompt/spaceship-prompt)
  `ZSH_THEME="spaceship"`

- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
  `ZSH_THEME="powerlevel10k/powerlevel10k"`

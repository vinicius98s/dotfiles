# Dotfiles

## Installation

**Requirements**
- [rcm](https://github.com/thoughtbot/rcm)

```
cd ~
git clone https://github.com/vinicius98s/dotfiles.git .dotfiles
sh install.sh
```

## Neovim configurations

`<leader> = Space`

**Requirements**
- [Neovim 0.5+](https://github.com/neovim/neovim)
- [Vim plug](https://github.com/junegunn/vim-plug)
- [fd](https://github.com/sharkdp/fd)
- [bat](https://github.com/sharkdp/bat)

To install plugins: `:PlugInstall`

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
- [Spaceship](https://github.com/spaceship-prompt/spaceship-prompt)
`ZSH_THEME="spaceship"`

- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
`ZSH_THEME="powerlevel10k/powerlevel10k"`


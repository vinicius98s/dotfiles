export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
export ERL_AFLAGS="-kernel shell_history enabled"

# ZSH_THEME="spaceship"
ZSH_THEME="ultima"

plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

### Added by Zinit's installer
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions

if [ ! -f ~/.gitconfig ]; then
  git config --global core.editor "vi"
  git config --global user.email "vinicius.2010.s@gmail.com"
  git config --global user.name "Vinicius Sales"

  # Git aliases
  git config --global alias.unstage "reset HEAD --"
  # 'git yolo' for something magic
  git config --global --add alias.yolo '!git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'
fi

is_installed() {
    if which "$1" >/dev/null 2>&1; then
        return 0 # true
    else
        return 1 # false
    fi
}

if is_installed "batcat"; then
  alias cat="batcat --paging=never"
fi 

#nvim
export PATH="$PATH:/opt/nvim-linux-arm64/bin"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

eval "$($HOME/.local/bin/mise activate zsh)"


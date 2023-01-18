export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.
export ERL_AFLAGS="-kernel shell_history enabled"

# ZSH_THEME="spaceship"
ZSH_THEME="guezwhoz"

plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

alias codezsh="code ~/.zshrc"

fpath=(${ASDF_DIR}/completions $fpath)
[ -f ~/.asdf/asdf.sh ] && . $HOME/.asdf/asdf.sh

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

git config --global user.email "vinicius.2010.s@gmail.com"
git config --global user.name "Vinicius Sales"

if ! [ -x "$(command -V batcat)" ]; then
  alias cat='batcat --paging=never'
fi 

# Git aliases
git config --global alias.unstage 'reset HEAD --'
# 'git yolo' for something magic
git config --global --add alias.yolo '!git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

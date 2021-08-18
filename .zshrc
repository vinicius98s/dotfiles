# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"
plugins=(git kubectl)

source $ZSH/oh-my-zsh.sh

alias codezsh="code ~/.zshrc"

fpath=(${ASDF_DIR}/completions $fpath)
. $HOME/.asdf/asdf.sh

### Added by Zinit's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

git config --global user.email "vinicius.2010.s@gmail.com"
git config --global user.name "Vinicius Sales"

# Git aliases
git config --global alias.unstage 'reset HEAD --'
# 'git yolo' for something magic
git config --global --add alias.yolo '!git commit -m "$(curl -s whatthecommit.com/index.txt)"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export ERL_AFLAGS="-kernel shell_history enabled"

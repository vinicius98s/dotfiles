# ayu-dark.zsh-theme
# Based on ultima v2.0.0 (https://github.com/egorlem/ultima.zsh-theme), recolored
# with the ayu dark palette so the shell matches colors/ayu-dark.lua and
# ayu-dark.tmuxtheme. Layout and behaviour are unchanged; only colors differ.

autoload -Uz compinit; compinit

# LOCAL/VARIABLES/PALETTE ======================================================
# https://github.com/ayu-theme/ayu-colors — requires zsh 5.7+ for %F{#rrggbb}

local ayu_line="#22262f"        # the horizontal rule
local ayu_ui="#565b66"          # structural glyphs
local ayu_comment="#636a72"     # muted labels
local ayu_accent="#e6b450"      # the ayu gold
local ayu_orange="#ff8f40"
local ayu_blue="#59c2ff"
local ayu_green="#aad94c"
local ayu_mint="#95e6cb"
local ayu_purple="#d2a6ff"
local ayu_red="#d95757"
local ayu_added="#7fd962"
local ayu_modified="#73b8ff"

# LOCAL/VARIABLES/ANSI =========================================================

local ANSI_reset="\x1B[0m"
local ANSI_rule="\x1B[38;2;34;38;47m"                           # $ayu_line

# LOCAL/VARIABLES/GRAPHIC ======================================================

local char_arrow="›"                                            #Unicode: ›
local char_up_and_right_divider="└"                             #Unicode: └
local char_down_and_right_divider="┌"                           #Unicode: ┌
local char_vertical_divider="─"                                 #Unicode: ─

# SEGMENT/VCS_STATUS_LINE ======================================================

export VCS="git"

local current_vcs="\":vcs_info:*\" enable $VCS"
local char_badge="%F{$ayu_comment} 𝗈𝗇 %f%F{$ayu_ui}${char_arrow}%f"
local vc_branch_name="%F{$ayu_green}%b%f"

local vc_action="%F{$ayu_orange}%a %f%F{$ayu_ui}${char_arrow}%f"
local vc_unstaged_status="%F{$ayu_modified} M ${char_arrow}%f"

local vc_git_staged_status="%F{$ayu_added} A ${char_arrow}%f"
local vc_git_hash="%F{$ayu_mint}%6.6i%f %F{$ayu_ui}${char_arrow}%f"
local vc_git_untracked_status="%F{$ayu_accent} U ${char_arrow}%f"


if [[ $VCS != "" ]]; then
  autoload -Uz vcs_info
  eval zstyle $current_vcs
  zstyle ':vcs_info:*' get-revision true
  zstyle ':vcs_info:*' check-for-changes true
fi

case "$VCS" in
   "git")
    # git sepecific
    zstyle ':vcs_info:git*+set-message:*' hooks use_git_untracked
    zstyle ':vcs_info:git:*' stagedstr $vc_git_staged_status
    zstyle ':vcs_info:git:*' unstagedstr $vc_unstaged_status
    zstyle ':vcs_info:git:*' actionformats "  ${vc_action} ${vc_git_hash}%m%u%c${char_badge} ${vc_branch_name}"
    zstyle ':vcs_info:git:*' formats " %c%u%m${char_badge} ${vc_branch_name}"
  ;;

  # svn sepecific
  "svn")
    zstyle ':vcs_info:svn:*' branchformat "%b"
    zstyle ':vcs_info:svn:*' formats " ${char_badge} ${vc_branch_name}"
  ;;

  # hg sepecific
  "hg")
    zstyle ':vcs_info:hg:*' branchformat "%b"
    zstyle ':vcs_info:hg:*' formats " ${char_badge} ${vc_branch_name}"
  ;;
esac

# Show untracked file status char on git status line
+vi-use_git_untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] &&
    git status --porcelain | grep -m 1 "^??" &>/dev/null; then
    hook_com[misc]=$vc_git_untracked_status
  else
    hook_com[misc]=""
  fi
}

# SEGMENT/SSH_STATUS ===========================================================

local ssh_marker=""

if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
 ssh_marker="%F{$ayu_purple}SSH%f%F{$ayu_ui}:%f"
fi

# UTILS ========================================================================

setopt PROMPT_SUBST

# Prepare git status line
prepareGitStatusLine() {
  echo '${vcs_info_msg_0_}'
}

# Prepare prompt line limiter
printPsOneLimiter() {
  local termwidth
  local spacing=""

  ((termwidth = ${COLUMNS} - 1))

  for i in {1..$termwidth}; do
    spacing="${spacing}${char_vertical_divider}"
  done

  echo $ANSI_rule$char_down_and_right_divider$spacing$ANSI_reset
}

# ENV/VARIABLES/PROMPT_LINES ===================================================

PROMPT="%F{$ayu_ui}${char_up_and_right_divider} ${ssh_marker} %f%F{$ayu_blue}%~%f$(prepareGitStatusLine)
%B%F{$ayu_accent} ${char_arrow}%f%b "

RPROMPT=""

# ENV/HOOKS ====================================================================

precmd() {
  if [[ $VCS != "" ]]; then
    vcs_info
  fi
  printPsOneLimiter
}

# SEGMENT/AUTOSUGGESTIONS ======================================================
# zsh-autosuggestions ghost text, matching BlinkCmpGhostText in neovim

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c7380"

# ENV/VARIABLES/LS_COLORS ======================================================

LSCOLORS=gxafexDxfxegedabagacad
export LSCOLORS

LS_COLORS=$LS_COLORS:\
"di=38;2;89;194;255":\
"ln=38;2;149;230;203":\
"so=38;2;210;166;255":\
"pi=38;2;230;180;80":\
"ex=38;2;170;217;76":\
"bd=38;2;255;143;64":\
"cd=38;2;255;143;64":\
"su=38;2;11;14;20;48;2;217;87;87":\
"sg=38;2;11;14;20;48;2;217;87;87":\
"ow=38;2;11;14;20;48;2;89;194;255":\
"tw=38;2;11;14;20;48;2;89;194;255":\
"*.js=38;2;255;180;84":\
"*.json=38;2;230;180;80":\
"*.jsx=38;2;57;186;230":\
"*.ts=38;2;89;194;255":\
"*.tsx=38;2;57;186;230":\
"*.css=38;2;210;166;255":\
"*.scss=38;2;210;166;255":\
"*.lua=38;2;89;194;255":\
"*.ex=38;2;210;166;255":\
"*.exs=38;2;210;166;255":\
"*.rs=38;2;255;143;64":\
"*.md=38;2;191;189;182":\
"*.zip=38;2;240;113;120":\
"*.tar=38;2;240;113;120":\
"*.gz=38;2;240;113;120"
export LS_COLORS

# SEGMENT/COMPLETION ===========================================================

setopt MENU_COMPLETE

local completion_descriptions="%B%F{$ayu_accent} ${char_arrow} %f%%F{$ayu_blue}%d%b%f"
local completion_warnings="%F{$ayu_orange} ${char_arrow} %fno matches for %F{$ayu_blue}%d%f"
local completion_error="%B%F{$ayu_red} ${char_arrow} %f%e %d error"

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list "m:{a-z}={A-Z}"
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:*:*:descriptions' format $completion_descriptions
zstyle ':completion:*:*:*:*:corrections' format $completion_error
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=38;2;11;14;20;48;2;230;180;80"
zstyle ':completion:*:*:*:*:warnings' format $completion_warnings
zstyle ':completion:*:*:*:*:messages' format "%d"

zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:approximate:*' max-errors "reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )"
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns "*?.o" "*?.c~" "*?.old" "*?.pro"
zstyle ':completion:*:functions' ignored-patterns "_*"

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ==============================================================================

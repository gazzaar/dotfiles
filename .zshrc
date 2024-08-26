
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
set -o vi
bindkey -M viins 'jk' vi-cmd-mode
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES="$HOME/dotfiles/"
export EDITOR=nvim
export VISUAL=nvim
export KLOG="$HOME/.nb/klog/"
export NB_EDITOR='nvim'
export BAT_THEME="gruvbox-dark"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/bin:$PATH"
export TERMINAL=Wezterm
export TERM='xterm-256color'
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_AUTO_UPDATE=true
export LANG=en_US.UTF-8

# DEFAULT_USER="gazzaar"
# prompt_context(){}
#
# # Set the prompt to display only the current directory name
# PS1='%1~ %# '
#
ZSH_THEME=""

# Sketchybar interactivity overloads
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# --------------------- Alises --------------------- #
alias c="clear"
alias arm="env /usr/bin/arch -arm64 /bin/zsh --login"
alias intel="env /usr/bin/arch -x86_64 /bin/zsh --login"
alias commit="git commit -m"
alias klog="cd $KLOG"
alias work="$HOME/.local/bin/work"
alias v="nvim"
alias t="tmux"
alias org="nb open area/ideas.org"
alias gs="git status"
alias dot="cd $DOTFILES"
alias cd="z"
alias ls="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions"
alias ll="eza -l --no-permissions"
alias e="exit"
alias lg="lazygit"
alias y="yazi"
# --------------------- fzf --------------------- #

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#fbf1c7,bg:-1,bg+:#262626
  --color=hl:#83a598,hl+:#458588,info:#afaf87,marker:#98971a
  --color=prompt:#b8bb26,spinner:#b16286,pointer:#d3869b,header:#87afaf
  --color=border:#d65d0e,preview-fg:#ebdbb2,preview-border:#689d6a,preview-scrollbar:#689d6a
  --color=label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆"
  --separator="─" --scrollbar="│" --layout="reverse-list"'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# thefuck alias 
eval $(thefuck --alias fk)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure


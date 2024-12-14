
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES="$HOME/dotfiles/"
export EDITOR=nvim
export BROWSER="Brave Browser"
export VISUAL=nvim
export KLOG="$HOME/.nb/klog/"
export NB_EDITOR='nvim'
export BAT_THEME="gruvbox-dark"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/bin:$PATH"
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23.0.1/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
export TERMINAL=Wezterm
export TERM='xterm-256color'
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_AUTO_UPDATE=true
export LANG=en_US.UTF-8


# Sketchybar interactivity overloads
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

# Syntax highlighting
# if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#     source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi

# Autosuggestions
# if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
#     source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# fi
#
#
 # plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
plugins=(git zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh

# --------------------- Alises --------------------- #
alias c="clear"
alias arm="env /usr/bin/arch -arm64 /bin/zsh --login"
alias intel="env /usr/bin/arch -x86_64 /bin/zsh --login"
alias minecraft="java -jar Tlauncher.jar"
alias commit="git commit -m"
alias klog="cd $KLOG"
alias work="$HOME/.local/bin/work"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias son="tmux set-option -g status on"
alias soff="tmux set-option -g status off"
alias t="tmux attach -t" 
alias org="vim $KLOG/area/ideas.org"
alias gs="git status"
alias dot="cd $DOTFILES"
alias cd="z"
alias ls="eza -x --color=always --git --no-filesize --no-time --no-user --no-permissions "
alias ll="eza -l "
alias e="exit"
alias lg="lazygit"
alias y="yazi"
alias logs="vim $KLOG/area/log.org"
alias ~='cd ~'
alias manage='ncdu /'
eval $(thefuck --alias)
# --------------------- fzf --------------------- #
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ebdbb2,bg:#1d2021,fg+:#fbf1c7,bg+:#3c3836
  --color=hl:#83a598,hl+:#458588,info:#fabd2f,marker:#98971a
  --color=prompt:#b8bb26,spinner:#d3869b,pointer:#fb4934,header:#8ec07c
  --color=border:#d65d0e,preview-fg:#ebdbb2,preview-bg:#282828
  --color=preview-border:#689d6a,preview-scrollbar:#a89984
  --color=gutter:#1d2021,query:#d9d9d9,label:#665c54
  --preview-window="border-rounded" 
  --prompt="❯ " 
  --marker="▶" 
  --pointer="◆" 
  --separator="─" 
  --scrollbar="│" 
  --layout="reverse-list"
  --border="rounded"
  --margin=1,2
  --padding=1
'
if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# thefuck alias 
eval $(thefuck --alias fk)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
unsetopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

################ I Made my own prompt above #######################3
# Set up Pure with your custom directory display
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

source /Users/fathysameh/.config/broot/launcher/bash/br

set -o vi
bindkey -M viins 'jk' vi-cmd-mode
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

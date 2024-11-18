
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

# DEFAULT_USER="gazzaar"
# prompt_context(){}

# Set the prompt to display only the current directory name
# PS1='%1~ %# '
# ZSH_THEME=robbyrussell

# Gruvbox color palette with Zsh escape sequences
GRUVBOX_BG=$'%{\e[48;5;235m%}'        # Dark background (not used)
GRUVBOX_GIT=$'%{\e[38;5;245m%}'       # Gray (#928374) for Git branch
GRUVBOX_ARROW=$'%{\e[38;5;132m%}'       # Purple (#b16286) for the current directory
GRUVBOX_DIR=$'%{\e[38;5;66m%}'      # Blue-gray (#458588) for arrows in insert mode
RESET=$'%{\e[0m%}'                    # Reset to default terminal colors

# Function to get the current Git branch and status
function git_branch {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    # Check for changes (unstaged or uncommitted)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      echo -n "${GRUVBOX_GIT}${branch}*${RESET} "
    else
      # Check if we need to push
      local ahead=$(git rev-list @{u}..HEAD 2>/dev/null | wc -l)
      # Check if we need to pull
      local behind=$(git rev-list HEAD..@{u} 2>/dev/null | wc -l)
      
      if [[ $ahead -gt 0 ]]; then
        echo -n "${GRUVBOX_GIT}${branch}↑${RESET} "
      elif [[ $behind -gt 0 ]]; then
        echo -n "${GRUVBOX_GIT}${branch}↓${RESET} "
      else
        echo -n "${GRUVBOX_GIT}${branch}${RESET} "
      fi
    fi
  fi
}

# Function to update the prompt based on vi mode
function update_prompt {
    if [[ $KEYMAP == vicmd ]]; then
        # Vim Normal Mode - Arrow points left, uses red color
        PROMPT="${GRUVBOX_DIR}%1~${RESET} ${GRUVBOX_ARROW}←${RESET} $(git_branch)"
    else
        # Vim Insert Mode - Arrow points right, uses blue color
        PROMPT="${GRUVBOX_DIR}%1~${RESET} ${GRUVBOX_ARROW}→${RESET} $(git_branch)"
    fi
}

# Wrapper function for zle-keymap-select
function zle-keymap-select {
    update_prompt
    zle reset-prompt
}

# Call the function whenever the keymap changes
zle -N zle-keymap-select

# Set the initial prompt based on vi mode
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt
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
alias ls="eza --color=always --long --git --no-filesize --no-time --no-user --no-permissions"
alias ll="eza -l "
alias e="exit"
alias lg="lazygit"
alias y="yazi"
alias logs="vim $KLOG/area/log.org"
alias ~='cd ~'
eval $(thefuck --alias)
# --------------------- fzf --------------------- #
#
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#fbf1c7,bg:-1,bg+:#262626
  --color=hl:#83a598,hl+:#458588,info:#afaf87,marker:#98971a
  --color=prompt:#b8bb26,spinner:#b16286,pointer:#d3869b,header:#87afaf
  --color=border:#d65d0e,preview-fg:#ebdbb2,preview-border:#689d6a,preview-scrollbar:#689d6a
  --color=label:#aeaeae,query:#d9d9d9
  --preview-window="border-rounded" --prompt="> " --marker=">" --pointer="◆"
  --separator="─" --scrollbar="│" --layout="reverse-list"'

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
# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit; promptinit
# prompt pure

source /Users/fathysameh/.config/broot/launcher/bash/br

set -o vi
bindkey -M viins 'jk' vi-cmd-mode
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

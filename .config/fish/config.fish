# Environment Variables
set -gx ZSH "$HOME/.oh-my-zsh"
set -gx DOTFILES "$HOME/dotfiles/"
set -gx EDITOR nvim
set -gx BROWSER "Brave Browser"
set -gx VISUAL nvim
set -gx KLOG "$HOME/.nb/klog/"
set -gx NB_EDITOR nvim
set -gx BAT_THEME gruvbox-dark
set -gx NVM_DIR "$HOME/.nvm"
set -gx JAVA_HOME "/opt/homebrew/Cellar/openjdk/23.0.1/libexec/openjdk.jdk/Contents/Home"
set -gx TERMINAL ghostty
set -gx TERM xterm-256color
set -gx HOMEBREW_NO_AUTO_UPDATE true
set -gx LANG en_US.UTF-8

fish_git_prompt

# Path modifications
fish_add_path /opt/homebrew/bin
fish_add_path $JAVA_HOME/bin

# Brew function with sketchybar integration
function brew --wraps command
    command brew $argv
    if string match -q -- "*upgrade*" "$argv" || string match -q -- "*update*" "$argv" || string match -q -- "*outdated*" "$argv"
        sketchybar --trigger brew_update
    end
end

# Aliases
alias c="clear"
alias arm="env /usr/bin/arch -arm64 /bin/fish --login"
alias intel="env /usr/bin/arch -x86_64 /bin/fish --login"
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
alias ls="eza -x --color=always --git --no-filesize --no-time --no-user --no-permissions --long"
alias ll="eza -l"
alias e="exit"
alias lg="lazygit"
alias logs="vim $KLOG/area/log.org"
alias manage='ncdu /'
alias study='python3 ~/dev/study-tracker/no_clip_study-tracker.py'
alias studytime='node ~/studyTrackerAdd/index.js'
alias fk='thefuck'
alias room="cd $KLOG/resources/room/daily/"

# FZF configuration
set -gx FZF_DEFAULT_OPTS "\
--color=fg:#ebdbb2,bg:#1d2021,fg+:#fbf1c7,bg+:#3c3836 \
--color=hl:#83a598,hl+:#458588,info:#fabd2f,marker:#98971a \
--color=prompt:#b8bb26,spinner:#d3869b,pointer:#fb4934,header:#8ec07c \
--color=border:#d65d0e,preview-fg:#ebdbb2,preview-bg:#282828 \
--color=preview-border:#689d6a,preview-scrollbar:#a89984 \
--color=gutter:#1d2021,query:#d9d9d9,label:#665c54 \
--preview-window='border-rounded' \
--prompt='❯ ' \
--marker='▶' \
--pointer='◆' \
--separator='─' \
--scrollbar='│' \
--layout='reverse-list' \
--border='rounded' \
--margin=1,2 \
--padding=1"

# FZF Fish configuration
set -g FZF_PREVIEW_FILE_CMD "head -n 10"
set -g FZF_PREVIEW_DIR_CMD ls
set -g FZF_TMUX_HEIGHT "40%"
set -g FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -g FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -g FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

# Load FZF key bindings
fzf_key_bindings
# Initialize zoxide (better cd)
zoxide init fish | source

# Vi mode configuration
fish_vi_key_bindings
bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

# Custom function for yazi file manager
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    set cwd (cat -- "$tmp")
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# History configuration
set -g fish_history_file $HOME/.local/share/fish/fish_history
set -g history_max_lines 1000

# FZF Functions for key bindings
function fish_user_key_bindings
    fzf_key_bindings
end

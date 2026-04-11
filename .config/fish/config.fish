# Environment Variables
set -gx ZSH "$HOME/.oh-my-zsh"
set -gx DOTFILES "$HOME/dotfiles/"
set -gx EDITOR vim
set -gx BROWSER "zen"
set -gx VISUAL nvim
set -gx KLOG "$HOME/.nb/klog/"
set -gx NB_EDITOR nvim
set -gx BAT_THEME gruvbox-dark
set -gx NVM_DIR "$HOME/.nvm"
set -gx JAVA_HOME "/opt/homebrew/Cellar/openjdk/23.0.1/libexec/openjdk.jdk/Contents/Home"
set -gx TERMINAL kitty
#set -gx TERMINAL wezterm
set -gx TERM xterm-256color
set -gx HOMEBREW_NO_AUTO_UPDATE true
set -gx LANG en_US.UTF-8

# Load nvm

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
alias arm="env /usr/bin/arch -arm64 /opt/homebrew/bin/fish --login"
alias intel="env /usr/bin/arch -x86_64 /usr/local/bin/fish --login"
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
alias ls="eza -x --color=never --git --no-quotes --no-filesize --no-time --no-user --no-permissions --long"
alias ll="eza -l --color=never --no-quotes --total-size"
alias e="exit"
alias lg="lazygit"
alias logs="nvim $KLOG/area/log.org"
alias manage='ncdu /'
########## Python version
#alias study='python3 ~/dev/study-tracker/no_clip_study-tracker.py'
#alias studytime='node ~/studyTrackerAdd/index.js'
########## NodeJS version
alias focus='node ~/dev/study-app/index.js study'
alias focustime='node ~/dev/study-app/index.js studytime'
alias fk='thefuck'
alias room="cd $KLOG/resources/room/daily/"
alias psqlstart="brew services start postgresql@14"
alias psqlstop="brew services stop postgresql@14"
alias mysqlstart="brew services start mysql"
alias mysqlstop="brew services stop mysql"
alias mysql="mysql -u root"
alias push="git push"
alias clone="git clone"
alias links='nvim ~/.nb/klog/resources/links.org'
alias y='yazi'
alias vp='vim package.json'
alias config="nvim $HOME/.config/fish/config.fish"
alias smath="open ~/Learning/Math/books/precalc-study.pdf"
alias update-nvim='asdf uninstall neovim stable && asdf install neovim stable'

# FZF configuration
########## Nord theme ##################
# set -gx FZF_DEFAULT_OPTS "
# --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1
# --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1
# --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
# --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b "

############# gruvbox-dark ###################
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
#
########### Alabaster ##############33
# set -gx FZF_DEFAULT_OPTS "
# --color=fg:#cecece,fg+:#cecece,bg:#0E1415,bg+:#293334
# --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00 
# --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf 
# --color=border:#262626,label:#aeaeae,query:#d9d9d9 
# --border='rounded' 
# --border-label='' 
# --preview-window='border-rounded' 
# --prompt='> ' 
# --marker='>' 
# --pointer='◆' 
# --separator='─' 
# --scrollbar='│'"

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
# function y
#    set tmp (mktemp -t "yazi-cwd.XXXXXX")
#    yazi $argv --cwd-file="$tmp"
#    set cwd (cat -- "$tmp")
#    if test -n "$cwd" -a "$cwd" != "$PWD"
#        cd -- "$cwd"
#    end
#    rm -f -- "$tmp"
# end
set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

# History configuration
set -g fish_history_file $HOME/.local/share/fish/fish_history
set -g history_max_lines 1000

# FZF Functions for key bindings
function fish_user_key_bindings
    fzf_key_bindings
end

#load_nvm >/dev/stderr
# Load NVM only when explicitly requested
function use_nvm
    if test -s "$NVM_DIR/nvm.sh"
        bass source "$NVM_DIR/nvm.sh"
    end
end

# Created by `pipx` on 2025-01-27 01:02:53
set PATH $PATH /Users/fathysameh/.local/bin
export DATABASE_PASSWORD="fat244hy"

# Added by Windsurf
fish_add_path /Users/fathysameh/.codeium/windsurf/bin
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# pnpm
set -gx PNPM_HOME /Users/fathysameh/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set -gx JAVA_HOME (/usr/libexec/java_home -v 21)

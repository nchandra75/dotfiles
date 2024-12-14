# ~/.config/fish/config.fish

# Function to check if a command exists
function has_command
    command -v $argv[1] >/dev/null 2>&1
end

# Alias for opening files easily
alias o='xdg-open'
# alias flatpak='flatpak --installation=shared'

# Set up better command alternatives with fallbacks
if has_command bat
    alias cat='bat --paging=never'
    set -gx PAGER bat
    set -gx BAT_PAGER "less -R"
else
    set -gx PAGER less
end
set -gx LESS -R

alias jjp='jj --no-pager'
alias cz=chezmoi
zoxide init fish | source
atuin init fish | source

if has_command eza
    alias ls='eza --group-directories-first'
    alias ll='eza -l --group-directories-first'
    alias la='eza -la --group-directories-first'
    alias l='eza -la --sort=modified'
    alias tree='eza --tree'
else
    alias ll='ls -l'
    alias la='ls -la'
    # On Linux ls, -t sorts by modification time, newest first
    # -r reverses the order so newest is last
    # -a shows hidden files
    alias l='ls -latr'
end

# Set CDPATH for quick directory navigation
set -gx CDPATH . ~ ~/work ~/work/current ~/scratch

# Configure command duration
set -g CMD_DURATION 0

# Function to format duration
function format_duration
    set -l duration $argv[1]
    if test $duration -gt 1000
        set -l seconds (math $duration / 1000)
        if test $seconds -gt 60
            set -l minutes (math $seconds / 60)
            set -l remaining_seconds (math $seconds % 60)
            echo "$minutes"m"$remaining_seconds"s
        else
            echo "$seconds"s
        end
    end
end

# Git/JJ status function
function vcs_status
    # Check for jj repository first
    if test -d .jj
        set -l branch (jj workspace list 2>/dev/null | string match -r '^\* (.*)' | string replace -r '^\* ' '')
        if test $status -eq 0
            set_color magenta
            printf " ($branch)"
        end
    # Then check for git repository (including worktrees)
    else if test -e .git
        set -l branch (git branch --show-current 2>/dev/null)
        if test $status -eq 0
            set_color yellow
            printf " ($branch)"
            set -l status (git status --porcelain 2>/dev/null)
            if test $status
                set_color red
                printf "*"
            end
        end
    end
    set_color normal
end

# Fish prompt function
function fish_prompt
    # Current working directory
    set_color blue
    printf '%s' (prompt_pwd)
    
    # VCS status (git/jj)
    vcs_status
    
    # Command duration
    if test $CMD_DURATION -gt 1000
        set_color cyan
        printf ' [%s]' (format_duration $CMD_DURATION)
    end
    
    # Current time
    set_color brblack
    printf ' [%s]' (date "+%H:%M:%S")
    
    # New line for the prompt
    printf '\n'
    
    # SSH host indicator (if connected via SSH)
    if set -q SSH_CONNECTION
        set_color yellow
        printf '@%s ' (hostname -s)
    end
    
    # Prompt character (# for root, > for regular user)
    if test (id -u) -eq 0
        set_color red
        printf '# '
    else
        set_color normal
        printf '> '
    end
    
    set_color normal
end

# Key bindings
function fish_user_key_bindings
    # Use Ctrl+F for accepting autosuggestion (similar to right arrow)
    bind \cf forward-char
    
    # Use Ctrl+R for searching command history
    bind \cr history-search-backward
end

# Universal abbreviations (persist across sessions)
abbr -a g git
abbr -a gst 'git status'
abbr -a gd 'git diff'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git pull'

# Set some sensible environment variables
set -gx EDITOR vim
set -gx VISUAL $EDITOR
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set --global --export HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
set --global --export HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
set --global --export HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
fish_add_path --global --move --path "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin";
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; set --global --export INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH; end;
if test -n "$XDG_DATA_DIRS"; set --global --export XDG_DATA_DIRS "/home/linuxbrew/.linuxbrew/share" $XDG_DATA_DIRS; end;

# For LD_LIBRARY_PATH (since fish_add_path is only for PATH)
if not contains /usr/local/cuda/lib64 $LD_LIBRARY_PATH
    if set -q LD_LIBRARY_PATH
        set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH
    else
        set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64
    end
end

starship init fish | source


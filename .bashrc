parse_git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch
        branch=$(git branch --show-current 2>/dev/null)
        if [ -n "$branch" ]; then
            echo " ($branch)"
        fi
    fi
}

export PS1="\W\[\033[1;32m\]\$(parse_git_branch)\[\033[0m\] \$ "

# 2. COLORIZED OUTPUTS
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GF'

# 3. USEFUL ALIASES
alias ll='ls -alF'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='source ~/.bashrc'

# 4. HISTORY MANAGEMENT
export HISTCONTROL=ignoredups:erasedups   # Don't record duplicate lines
export HISTSIZE=10000                     # Big history buffer
export HISTFILESIZE=20000
shopt -s histappend                       # Append to history, don't overwrite

# 5. HOMEBREW PATHS (Crucial for Apple Silicon Macs)
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
        source "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
        source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
fi

# --- Oh My Zsh Git Aliases for Bash ---
alias g='git'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gco='git switch'
alias gcb='git switch -c'
alias gcm='git switch $(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@")'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias glog='git log --oneline --decorate --graph'

. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="/Users/apashkouski/.local/bin:$PATH"

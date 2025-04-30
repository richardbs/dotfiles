# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Aliases
alias ll='ls -lah --color=auto'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Set EDITOR
export EDITOR=nano

# Load Starship Prompt
eval "$(starship init bash)"

# Git prompt settings
export GIT_PS1_SHOWDIRTYSTATE=1

echo "Welcome, $USER 👋"

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# conf files are in ~/.zsh
export ZDOTDIR=$HOME/.zsh

# Source grml
if [[ -s "${ZDOTDIR:-$HOME}/grml/.zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/grml/.zshrc"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# cdr allows to come back to a previous visited directory
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Setopt

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Glob is clever research / completion
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT
setopt GLOB_COMPLETE

# ignore command starting with a space in history
setopt hist_ignore_space


# key binding

# Tab -> complete or next completion
bindkey '^i' expand-or-complete-prefix

# Alias

# builtin
alias ls="ls --color -h --group-directories-first -X"
alias sz="source $HOME/.zshrc"

# cmake
alias b="mkdir build; cd build"
alias nb="rm -rf build; b"
alias rmcmake="rm -rf CMakeFiles Makefile cmake_install.cmake CMakeCache.txt"

# git
alias gitgraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# Alias post command

alias -g G="| grep"
alias -g L="| less"

alias -s txt=vim

# Env
export VISUAL="vim"
export EDITOR=$VISUAL
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

# Functions

fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '' fancy-ctrl-z

# Custom conf (in home or folder .zsh)
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.postconf" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.postconf"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# conf files are in ~/.zsh
export ZDOTDIR=$HOME/.zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# menu
zstyle ':completion:*' menu select

# cdr allows to come back to a previous visited directory
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# module

autoload -U compinit promptinit zcalc zsh-mime-setup
compinit
promptinit
zsh-mime-setup

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# ignore command starting with a space
setopt hist_ignore_space

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# Egomaniac!
zstyle ':completion:*' list-separator 'fREW'

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed false

# Tab -> complete or next completion
bindkey '^i' expand-or-complete-prefix

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

# Alias

# builtin
alias ls="ls --color -h --group-directories-first -X"

# cmake
alias b="mkdir build; cd build"
alias nb="rm -rf build; b"

# Alias post command

alias -g G="| grep"
alias -g L="| less"

alias -s txt=vim

# Env
export EDITOR="vim"
export SVN_EDITOR=$EDITOR

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

# Custom conf
if [[ -s "${HOME}/.zshrc.postconf" ]]; then
  source "${HOME}/.zshrc.postconf"
fi

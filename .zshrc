# Created bu Charles Gueunet <charles.gueunet+zsh@gmail.com>


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

# Remove annoying file redirection error
setopt CLOBBER

# autocomplete

zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# ignore command starting with a space in history
setopt HIST_IGNORE_SPACE

# avoid automatic change the title
DISABLE_AUTO_TITLE=true

# key binding

# Tab -> complete or next completion
bindkey '^i' expand-or-complete-prefix

# vi mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^r' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Alias

# builtin
alias ls="ls --color -h --group-directories-first -X"
alias sz="source $HOME/.zshrc"
alias sue="su; exit"

# cmake
alias b="mkdir build; cd build"
alias rb="rm -rf build/"
alias nb="rb; b"
alias rmcmake="rm -rf CMakeFiles Makefile cmake_install.cmake CMakeCache.txt"

# git
alias gitgraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# Alias post command

alias -g G="| grep"
alias -g L="| less"
alias -g S="| sed"

alias -s txt=vim

# Env
export VISUAL="vim"
export EDITOR=$VISUAL
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR

# Functions

# ctrl z
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

# tmux

start-tmux () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="tmux -2"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N start-tmux
bindkey '' start-tmux

att-tmux () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="tmux -2 a"
        zle accept-line
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N att-tmux
bindkey '' att-tmux

# vi indicator

precmd() {
  RPROMPT=""
}
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="(CMD)"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

export KEYTIMEOUT=1

# Custom conf (in home or folder .zsh)
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.postconf" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.postconf"
fi

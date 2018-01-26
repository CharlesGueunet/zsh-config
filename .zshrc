# Created by Charles Gueunet <charles.gueunet+zsh@gmail.com>

# Follow the link (if any) to find the config folder
if [ -L $HOME/.zshrc ]; then
    export ZDOTDIR=$(dirname `readlink -f $HOME/.zshrc`)
else
    export ZDOTDIR=${HOME}/.zsh/
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/grml/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/grml/zshrc"
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

# avoid automatic change the title
DISABLE_AUTO_TITLE=true

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
# fuzzy completion when mistype
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# history

setopt APPEND_HISTORY

# ignore command starting with a space in history
setopt HIST_IGNORE_SPACE

# remove duplicate blanks
setopt HIST_REDUCE_BLANKS

# key binding

# Tab -> complete or next completion
bindkey '^i' expand-or-complete-prefix

# vi mode
bindkey -v
bindkey -M viins "$key_info[Control]P" up-line-or-search
bindkey -M viins "$key_info[Control]N" down-line-or-search
bindkey -M viins "$key_info[Control]R" history-incremental-search-backward
bindkey -M viins "$key_info[Up]" up-line-or-search
bindkey -M viins "$key_info[Down]" down-line-or-search
bindkey -M viins "$key_info[Control]Y" vi-end-of-line

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

# tmux
alias t="tmux -2"
alias ta="tmux -2 a"

# Keyboard qwerty with accent
# and "," (leader) on Caps Lock
alias rebind='setxkbmap -model pc104 -option compose:rctrl ; xmodmap -e "keycode 66 = comma Escape NoSymbol NoSymbol" ; xmodmap -e "clear lock"'

# Alias post command

alias -g G="| grep"
alias -g L="| less"
alias -g S="| sed"
alias -g V="| vim - "
alias -g X="| xclip"

alias -s txt=vim

# Env
export VISUAL="vim"
export EDITOR=$VISUAL
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export KEYTIMEOUT=1

# true color vim / tmux
if [[ -z $TMUX && -z $STY ]]; then
    export TERM='xterm-256color'
fi

# Functions

# man inside vim with completion
vman () {
    MANWIDTH=150 MANPAGER='col -bx' man $@ | vim -R -c "set ft=man" -
}
fpath=($HOME/.zsh/completion/ $fpath)

# ctrl z back and forth
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

# vi indicator
precmd() {
  RPROMPT=""
}
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT='[%F{yellow}NORMAL%F{reset}]'
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

# Other conf

# Custom conf (in home or folder .zsh)
if [[ -s "${ZDOTDIR:-$HOME}/.zshrc.postconf" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshrc.postconf"
fi

# fuzzy completion with ctrl-r / ctrl-t / alt-c
if [[ -f "${ZDOTDIR}/fzf.zsh" ]]; then
    source "${ZDOTDIR}/fzf.zsh"
fi

# Created by Charles Gueunet <charles.gueunet+zsh@gmail.com>

# Follow the link (if any) to find the config folder
if [ -L "$HOME/.zshrc" ]; then
   export ZDOTDIR=$(dirname `readlink -f $HOME/.zshrc`)
else
   export ZDOTDIR="${HOME}/.config/zsh/"
fi

# tmux autostart
# ##############

# ZJ_SESSIONS=$(zellij list-sessions)
# NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)
# if [ "${NO_SESSIONS}" -ge 2 ]; then
#     zellij attach \
#     "$(echo "${ZJ_SESSIONS}" | sk)"
# else
#    zellij attach -c
# fi

# if [[ -z "$ZELLIJ" ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c
#     else
#         zellij
#     fi
#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# elif command -v tmux &> /dev/null && [[ $UID -ne 0 ]] && [[ -v DISPLAY ]] && [[ -v KITTY_WINDOW_ID ]] && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

# notify
# ######

if [[ -v DISPLAY && -s "${ZDOTDIR:-$HOME}/notify/notify.plugin.zsh" ]]; then
   source "${ZDOTDIR:-$HOME}/notify/notify.plugin.zsh"
   zstyle ':notify:*' error-title "Command failed (#{time_elapsed} seconds)"
   zstyle ':notify:*' success-title "Command success (#{time_elapsed} seconds)"
   zstyle ':notify:*' expire-time 2500
fi

# ZComet
# ######

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone "https://github.com/agkozak/zcomet.git" "${ZDOTDIR}/.zcomet/bin"
fi

source ${ZDOTDIR}/.zcomet/bin/zcomet.zsh

# Plugins list
source ${ZDOTDIR}/plugins_list.zsh
if [[ -a ${ZDOTDIR}/plugins_custom_list.zsh ]]; then
   source ${ZDOTDIR}/plugins_custom_list.zsh
fi

# Run compinit and compile its cache
zcomet compinit

# # Plugins configuration
source ${ZDOTDIR}/plugins_conf.zsh
if [[ -a ${ZDOTDIR}/plugins_custom_conf.zsh ]]; then
   source ${ZDOTDIR}/plugins_custom_conf.zsh
fi

# Kak mode
# #######

source "${ZDOTDIR}/kak-mode.zsh"
zle_highlight=(region:bg=green,fg=black)

# edit
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# prompt
# #####

eval "$(starship init zsh)"

# Global settings
# ###############

# cdr allows to come back to a previous visited directory
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# OPTIONS

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# avoid automatic change the title
DISABLE_AUTO_TITLE=true
ZSH_THEME_TERM_TITLE_IDLE="%~"

# Glob is clever research / completion
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# Remove annoying file redirection error
setopt CLOBBER

# Job control
setopt monitor

# automatic cd
setopt auto_cd
export DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome

# autocomplete
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
# fuzzy completion when mistype
bindkey "^Xa" _expand_alias
zstyle ':completion:*' completer _expand_alias _complete _match _approximate
zstyle ':completion:*' regular true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"                       # color output with LS_COLORS
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'eza -1 --color=always $realpath' # Preview directories with eza

# history
HISTFILE=${ZDOTDIR}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt BANG_HIST
setopt HIST_REDUCE_BLANKS

# key binding

# Tab -> complete or next completion
bindkey '^i' expand-or-complete-prefix

# Multiple dot to up
if is-at-least 5.0.0 && [[ ! $UID -eq 0 ]]; then
  ## http://www.zsh.org/mla/users/2010/msg00769.html
  function rationalise-dot() {
    local MATCH # keep the regex match from leaking to the environment
    if [[ $LBUFFER =~ '(^|/| |      |'$'\n''|\||;|&)\.\.$' && ! $LBUFFER = p4* ]]; then
        #if [[ ! $LBUFFER = p4* && $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        zle self-insert
    fi
  }
  zle -N rationalise-dot
  bindkey . rationalise-dot
  bindkey -M isearch . self-insert
fi

# Aliases
# #######

typeset -a ealiases
ealiases=()

function ealias()
{
    alias $1
    ealiases+=(${1%%\=*})
}

function expand-ealias()
{
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}

zle -N expand-ealias

# Custom PATH
if [[ -d "${ZDOTDIR}/bin" ]]; then
  export PATH=$PATH:"${ZDOTDIR}/bin"
fi
if [[ -d "${HOME}/.cargo/bin" ]]; then
  export PATH=$PATH:${HOME}/.cargo/bin
fi

# builtin
alias sz="source $HOME/.zshrc"
alias clear="printf '\33[H\33[2J'"
alias startm="XINITRC=$HOME/.xinitrc_mate startx"

if type eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias l='eza -lh --group-directories-first'
  alias ll='eza -l --group-directories-first --all'
  alias lt='eza -T --git-ignore --level=2 --group-directories-first'
  alias lg='eza -l --all --group-directories-first --git'
else
  alias l='ls -lah'
  alias ll='ls -alF'
  alias la='ls -A'
fi


# cmake
ealias b="mkdir build"
ealias cb="cd build"
ealias rb="rm -rf build/"
ealias rmcmake="rm -rf CMakeFiles Makefile cmake_install.cmake CMakeCache.txt build.ninja rules.ninja"

alias -g CMB="-C ~/.config/cmake/base.cmake"
# alias -g NM="-G 'Ninja Multi-Config'"
alias -g NN="-G 'Ninja'"
alias -g CD="--config Debug"
alias -g CR="--config Release"
alias -g BB="--build build"
alias -g BP="--build ."
alias -g TI="--target install"
alias -g MP="-- -j 6 -l 5"

# editor
alias ks='. ${ZDOTDIR}/bin/kks-new'
alias kd='. ${ZDOTDIR}/bin/kks-detach'
alias kk='. ${ZDOTDIR}/bin/kks-kill'
alias kss='eval $(kks-switch)'
alias :q="exit"
alias :e="ke"
alias a="kks a"
alias cat="bat --paging=never"
alias less="bat --paging=always"

# git
ealias gitgraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias GD="GIT_EXTERNAL_DIFF=difft"

# tmux
ealias t="tmux -2"
ealias ta="tmux -2 a"
function tmux-kill-unnamed {
  tmux ls -F'#{session_name}'|grep -E '^[0-9]+$'|xargs -I% tmux kill-session -t "=%"
}

# zellij
ealias z="zellij"
ealias za="zellij attach "

# Keyboard qwerty with accent
if [[ -f "${HOME}/.Xmodmap" ]]; then
   alias rebind="setxkbmap -option compose:rctrl ; xmodmap ${HOME}/.Xmodmap"
else
   alias rebind='setxkbmap -option compose:ralt'
fi

# Alias post command

alias -g G="| grep "
alias -g L="| less "
alias -g T="| tee -a "
alias -g S="| sed "
alias -g V="| vim - "
alias -g XC="| xsel --clipboard "
alias -g XV="\`xsel --clipboard  --output\`"
alias -g X="| xargs "

alias -s {bib, c, cmake, cpp, h, hpp, md, rb, tex, txt, xml}="$EDITOR"
alias -s {vtu, vti, vtp, vtr, stl}="paraview"

# Env
export VISUAL="ke"
export EDITOR=$VISUAL
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export TIG_EDITOR=$EDITOR
export KEYTIMEOUT=1
export BC_LINE_LENGTH=0 # fix for bc when no newline
export GOPATH=$HOME/Software/go

# Functions (binded to keys)
# #########

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
bindkey '^z' fancy-ctrl-z

# ctrl v file manager
vicd()
{
   # from https://wiki.vifm.info/index.php?title=How_to_set_shell_working_directory_after_leaving_Vifm
   # Syncro vifm and shell
   local dst="$(command vifm --choose-dir - .)"
   if [ -z "$dst" ]; then
      echo 'Directory picking cancelled/failed'
      return 1
   fi
   cd "$dst"
}
vifm-call() {
  if [[ -z $BUFFER ]]; then
    # interpreted at start, not when leaving
    BUFFER="vicd"
    zle accept-line
  fi
}
zle -N vifm-call
bindkey '^v' vifm-call

# ctrl b pueue status
pueue-call() {
  if [[ -z $BUFFER ]]; then
    # interpreted at start, not when leaving
    BUFFER="clear; pueue status"
    zle accept-line
  fi
}
zle -N pueue-call
bindkey '^b' pueue-call

# ctrl g command replace
substitute-last() {
  if [[ -z $BUFFER ]]; then
    # interpreted at start, not when leaving
    BUFFER="!!:gs/"
    CURSOR=6
  fi
}
zle -N substitute-last
bindkey '^g' substitute-last

function mkcd {
   mkdir -p -- "$1"
   cd -P -- "$1"
}

# mv in folder and cd when it is done
function mvc(){
  lastArg=${@:$#}
  if [ -d "$lastArg" ]; then
    mv $@
    cd $lastArg
    unset	lastArg
  else
    echo "Last argument is not a folder"
    return 1
  fi
}

# clear on enter
if ! typeset -f magic-enter > /dev/null; then
  magic-enter() {
    if [[ -z "$BUFFER" ]]; then
      zle clear-screen
    else
      # Call built-in accept-line
      zle .accept-line
    fi
  }
  zle -N accept-line magic-enter
fi

# Ctrl o: previous vim/kak like
magic-popd () {
   if [[ -z $BUFFER ]]; then
      popd
      zle accept-line
   fi
}
zle -N magic-popd
bindkey "^o" magic-popd

# Additional conf
# ###############

# fuzzy completion with ctrl-r / ctrl-t / alt-c
if [[ -f "${ZDOTDIR}/fzf_binding.zsh" ]]; then
  source "${ZDOTDIR}/fzf_binding.zsh"
fi

if [[ -f "${ZDOTDIR}/LS_COLORS" ]]; then
  eval $(dircolors -b "${ZDOTDIR}/LS_COLORS")
fi

# direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# broot launcher
if [[ -f "${HOME}/.config/broot/launcher/bash/br" ]]; then
  source "${HOME}/.config/broot/launcher/bash/br"
fi

# Custom conf (in $ZDOTDIR or $HOME)
if [[ -f "${ZDOTDIR}/zshrc_custom.zsh" ]]; then
  source "${ZDOTDIR}/zshrc_custom.zsh"
fi

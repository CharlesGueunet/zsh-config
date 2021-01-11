# Created by Charles Gueunet <charles.gueunet+zsh@gmail.com>

# Follow the link (if any) to find the config folder
if [ -L $HOME/.zshrc ]; then
   export ZDOTDIR=$(dirname `readlink -f $HOME/.zshrc`)
else
   export ZDOTDIR=${HOME}/.config/zsh/
fi

# tmux autostart
# ##############

if command -v tmux &> /dev/null && [[ $UID -ne 0 ]] && [[ -v DISPLAY ]] && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# notify
# ######

if [[ -v DISPLAY && -s "${ZDOTDIR:-$HOME}/notify/notify.plugin.zsh" ]]; then
   source "${ZDOTDIR:-$HOME}/notify/notify.plugin.zsh"
   zstyle ':notify:*' error-title "Command failed (#{time_elapsed} seconds)"
   zstyle ':notify:*' success-title "Command success (#{time_elapsed} seconds)"
   zstyle ':notify:*' blacklist-regex 'kak|vim'
   zstyle ':notify:*' expire-time 2500
fi

# ZPlug
# #####

# download and source
export ZPLUG_HOME=$ZDOTDIR/zplug/
if [[ ! -a ${ZPLUG_HOME} ]]; then
   git clone  --recursive --depth 1 https://github.com/zplug/zplug $ZPLUG_HOME
fi
source ${ZPLUG_HOME}/init.zsh

# Plugins list
source ${ZDOTDIR}/plugins_list.zsh
if [[ -a ${ZDOTDIR}/plugins_custom_list.zsh ]]; then
   source ${ZDOTDIR}/plugins_custom_list.zsh
fi

# Plugins configuration
source ${ZDOTDIR}/plugins_conf.zsh
if [[ -a ${ZDOTDIR}/plugins_custom_conf.zsh ]]; then
   source ${ZDOTDIR}/plugins_custom_conf.zsh
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
   printf "Install? [y/N]: "
   if read -q; then
      echo; zplug install
   fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Custom PATH
# ###########

if [[ -d "${ZDOTDIR}/bin" ]]; then
  export PATH=$PATH:"${ZDOTDIR}/bin"
fi

# Vi mode
# #######

# binding
bindkey -v
bindkey -M viins "$key_info[Control]P" up-line-or-search
bindkey -M viins "$key_info[Control]N" down-line-or-search
bindkey -M viins "$key_info[Control]R" history-incremental-search-backward
bindkey -M viins "$key_info[Up]" up-line-or-search
bindkey -M viins "$key_info[Down]" down-line-or-search
if zplug check 'modules/autosuggestions'; then
    bindkey -M viins "$key_info[Control]Y" vi-end-of-line
    bindkey -M viins "$key_info[Control]F" vi-forward-word
fi

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

# builtin
alias sz="source $HOME/.zshrc"
alias sue="su; exit"

if type exa >/dev/null 2>&1; then
  alias ls='exa --group-directories-first --git'
  alias l='exa -l --group-directories-first --git'
  alias ll='exa -l --all --all --group-directories-first --git'
  alias lt='exa -T --git-ignore --level=2 --group-directories-first'
  alias llt='exa -lT --git-ignore --level=2 --group-directories-first'
  alias lT='exa -T --git-ignore --level=4 --group-directories-first'
else
  alias l='ls -lah'
  alias ll='ls -alF'
  alias la='ls -A'
fi


# cmake
ealias b="mkdir build; cd build"
ealias rb="rm -rf build/"
ealias nb="rb; b"
ealias rmcmake="rm -rf CMakeFiles Makefile cmake_install.cmake CMakeCache.txt build.ninja rules.ninja"

alias -g DD="-C ~/.config/base.cmake"
alias -g NM="-G 'Ninja Multi-Config'"
alias -g CB="--config Debug"
alias -g CR="--config Release"
alias -g BB="--build build"
alias -g BP="--build ."
alias -g TI="--target install"
alias -g MP="-- -j 6 -l 5"

# editor
alias k="kak"
alias :q="exit"

# git
ealias gitgraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# tmux
ealias t="tmux -2"
ealias ta="tmux -2 a"
function tmux-kill-unnamed {
  tmux ls -F'#{session_name}'|egrep '^[0-9]+$'|xargs -I% tmux kill-session -t "=%"
}

# Keyboard qwerty with accent
if [[ -f "${HOME}/.Xmodmap" ]]; then
   alias rebind="setxkbmap -option compose:rctrl ; xmodmap ${HOME}/.Xmodmap"
else
   alias rebind='setxkbmap -option compose:ralt'
fi

# Env
export VISUAL="kak"
export EDITOR=$VISUAL
export SVN_EDITOR=$EDITOR
export GIT_EDITOR=$EDITOR
export KEYTIMEOUT=1

# Alias post command

alias -g G="| grep"
alias -g L="| less"
alias -g T="| tee -a "
alias -g S="| sed"
alias -g V="| vim - "
alias -g X="| xclip"
alias -g XX="\`xclip -o\`"

alias -s {bib, c, cmake, cpp, h, hpp, md, rb, tex, txt, xml}=$EDITOR
alias -s {vtu, vti, vtp, vtr, stl}=paraview

# Functions (binded to keys)
# #########

# man inside vim with completion
vman () {
   MANWIDTH=150 MANPAGER='col -bx' man $@ | vim -R -c "set ft=man" -
}
fpath=($ZDOTDIR/completion/ $fpath)

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
  # interpreted at start, not when leaving
  BUFFER="!!:gs/"
  CURSOR=6
}
zle -N substitute-last
bindkey '^g' substitute-last

# fix for separate env
function su {
   # Fix for zplug, we don't want the new user to share ZPLUG variables
   command su -l $@
}

# Facade to zplug
function plugins(){
   zplug $@
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

# Empty command = clear
magic-enter () {
   if [[ -z $BUFFER ]]; then
      zle clear-screen
   else
      zle accept-line
   fi
}
zle -N magic-enter
bindkey "^m" magic-enter

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

# Custom conf (in $ZDOTDIR or $HOME)
if [[ -f "${ZDOTDIR}/zshrc_custom.zsh" ]]; then
  source "${ZDOTDIR}/zshrc_custom.zsh"
fi


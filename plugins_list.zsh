source ${ZPLUG_HOME}/init.zsh

# prezto
zplug  "modules/environment", from:prezto
zplug  "modules/editor", from:prezto, on:"modules/environment"
zplug  "modules/history", from:prezto, on:"modules/environment"
zplug  "modules/directory", from:prezto, on:"modules/environment"
zplug  "modules/utility", from:prezto, on:"modules/environment"
zplug  "modules/spectrum", from:prezto, on:"modules/environment"
zplug  "modules/ssh", from:prezto, on:"modules/environment"
zplug  "modules/rsync", from:prezto, on:"modules/environment"
zplug  "modules/archive", from:prezto, on:"modules/environment"
zplug  "modules/tmux", from:prezto, on:"modules/environment"
zplug  "modules/autosuggestions", from:prezto, on:"modules/environment"
zplug  "modules/history-substring-search", from:prezto, on:"modules/environment"
zplug  "modules/prompt", from:prezto, on:"modules/environment"

# other
zplug "zsh-users/zsh-syntax-highlighting", defer:1
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf

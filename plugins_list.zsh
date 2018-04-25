# let zplug manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# prezto, depth:1
zplug  "modules/environment", from:prezto, depth:1
zplug  "modules/editor", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/history", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/directory", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/spectrum", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/ssh", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/archive", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/autosuggestions", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/history-substring-search", from:prezto, depth:1, on:"modules/environment"
zplug  "modules/prompt", from:prezto, depth:1, on:"modules/environment"

# other
zplug "zsh-users/zsh-syntax-highlighting", depth:1, defer:1
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf

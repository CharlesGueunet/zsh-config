# autosuggestions
bindkey -M viins '^ ' autosuggest-accept
bindkey -M viins '^Y' autosuggest-accept
bindkey -M viins '^F' vi-forward-word

# FZF
export FZF_DEFAULT_OPTS='--height 40% --border --preview "less -$LINES {}"'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore-dir={.git,.ccls-cache,build,buildD,buildR} -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


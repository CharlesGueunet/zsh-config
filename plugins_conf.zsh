if zplug check 'modules/editor'; then
   # Set the key mapping style to 'emacs' or 'vi'. : remove tab completion
   zstyle ':prezto:module:editor' key-bindings 'vi'
   # Auto convert .... to ../..
   zstyle ':prezto:module:editor' dot-expansion 'yes'
fi

if zplug check 'modules/ssh'; then
   # Set the SSH identities to load into the agent.
   zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'
fi

if zplug check 'modules/autosuggestions'; then
   zstyle ':prezto:module:autosuggestions' color 'yes'
   zstyle ':prezto:module:autosuggestions:color' found 'fg=cyan'
fi

if zplug check 'modules/history-substring-search'; then
   # Set the query found color.
   zstyle ':prezto:module:history-substring-search:color' found 'green'
   # Set the query not found color.
   zstyle ':prezto:module:history-substring-search:color' not-found 'red'
fi

if zplug check 'junegunn/fzf-bin'; then
   # widget size
   export FZF_DEFAULT_OPTS='--height 40% --border --preview "less -$LINES {}"'
   export FZF_DEFAULT_COMMAND='ag --hidden --ignore-dir={.git,.ccls-cache,build,buildD,buildR} -g ""'
   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

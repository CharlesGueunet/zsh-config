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
   zstyle ':prezto:module:history-substring-search:color' found 'blue'
   # Set the query not found color.
   zstyle ':prezto:module:history-substring-search:color' not-found 'red'
fi

if zplug check 'modules/prompt'; then
   # Set the prompt theme to load.
   # Setting it to 'random' loads a random theme.
   # Auto set to 'off' on dumb terminals.
   zstyle ':prezto:module:prompt' theme 'grml'
fi

if zplug check 'junegunn/fzf-bin'; then
   # widget size
   export FZF_DEFAULT_OPTS='--height 40% --border --preview "less -$LINES {}"'
   export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi

if zplug check 'b4b4r07/enhancd'; then
   export ENHANCD_FILTER=fzy:fzf
   export ENHANCD_COMMAND=cdd
fi

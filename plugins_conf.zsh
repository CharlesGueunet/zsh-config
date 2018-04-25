#
# Editor
#

# Set the key mapping style to 'emacs' or 'vi'. : remove tab completion
zstyle ':prezto:module:editor' key-bindings 'vi'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'


#
# SSH
#

# Set the SSH identities to load into the agent.
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

#
# Auto-Suggestions
#

zstyle ':prezto:module:autosuggestions' color 'yes'
zstyle ':prezto:module:autosuggestions:color' found 'fg=cyan'

#
# History Substring Search
#

# Set the query found color.
zstyle ':prezto:module:history-substring-search:color' found 'blue'

# Set the query not found color.
zstyle ':prezto:module:history-substring-search:color' not-found 'red'

#
# Prompt
#

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':prezto:module:prompt' theme 'grml'

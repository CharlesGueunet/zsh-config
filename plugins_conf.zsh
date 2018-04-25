#
# Editor
#

# Set the key mapping style to 'emacs' or 'vi'. : remove tab completion
zstyle ':prezto:module:editor' key-bindings 'vi'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'

#
# GNU Utility
#

# Set the command prefix on non-GNU systems.
zstyle ':prezto:module:gnu-utility' prefix 'g'

#
# SSH
#

# Set the SSH identities to load into the agent.
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa2' 'id_github'

#
# Tmux
#

# Auto start a session when Zsh is launched in a local terminal.
#zstyle ':prezto:module:tmux:auto-start' local 'yes'

# Auto start a session when Zsh is launched in a SSH connection.
#zstyle ':prezto:module:tmux:auto-start' remote 'yes'

#
# Completion
#

#zstyle ':prezto:module:completion:*' menu select=10

## Separate man page sections.  Neat.
#zstyle ':prezto:module:completion:*:manuals' separate-sections true

## Egomaniac!
#zstyle ':prezto:module:completion:*' list-separator 'fREW'

## Errors format
#zstyle ':prezto:module:completion:*:corrections' format '%B%d (errors %e)%b'

## Don't complete stuff already on the line
#zstyle ':prezto:module:completion::*:(rm|vi):*' ignore-line true

## Don't complete directory we are already in (../here)
#zstyle ':prezto:module:completion:*' ignore-parents parent pwd
#zstyle ':prezto:module:completion::approximate*:*' prefix-needed false

#zstyle ':prezto:module:completion:*' list-suffixes true

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

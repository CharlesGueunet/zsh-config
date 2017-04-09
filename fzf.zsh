# Setup fzf
# ---------
if [[ ! "$PATH" == *${ZDOTDIR}/.fzf/bin* ]]; then
  export PATH="$PATH:${ZDOTDIR}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${ZDOTDIR}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${ZDOTDIR}/.fzf/shell/key-bindings.zsh"


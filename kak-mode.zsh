#emulate -L zsh
#
# kak mode for zsh
bindkey -v

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# switch to vi (kak) mode
bindkey -v

# bindkey - visual
# don't use visual keymap - only visual mode
bindkey -N visual

# common
kak-remove-visual() {
  test 1 -eq ${REGION_ACTIVE} && zle visual-mode
}
zle -N kak-remove-visual

kak-reset-visual() {
  # restart, if already active
  zle kak-remove-visual
  zle visual-mode
}
zle -N kak-reset-visual

kak-accept-line() {
  zle kak-remove-visual
  zle accept-line
}
zle -N kak-accept-line


# viins
kak-cmd-mode() {
  zle vi-cmd-mode
  zle kak-reset-visual
}
zle -N kak-cmd-mode

# bindkey - viins
# reuse viins keymap
bindkey -M viins "^J" kak-accept-line
bindkey -M viins "^L" clear-screen
bindkey -M viins "^M" kak-accept-line
bindkey -M viins "^[" kak-cmd-mode


# vicmd
# history (search)
kak-down-line() {
  # default is just history, not search
  #zle down-line-or-history
  zle down-line-or-beginning-search
  zle vi-end-of-line
  zle kak-reset-visual
}
zle -N kak-down-line

kak-up-line() {
  # default is just history, not search
  #zle up-line-or-history
  zle up-line-or-beginning-search
  zle vi-end-of-line
  zle kak-reset-visual
}
zle -N kak-up-line

# indent (4 spaces)
kak-indent() {
  CS=${CURSOR}
  BUFFER="    ${BUFFER}"
  CURSOR=$(( ${CS} + 4 ))
  zle kak-reset-visual
}
zle -N kak-indent

kak-unindent() {
  CS=${CURSOR}
  BS=${#BUFFER}
  BUFFER="${BUFFER#    }"
  test "${BS}" = "${#BUFFER}" || CURSOR=$(( ${CS} - 4 ))
  zle kak-reset-visual
}
zle -N kak-unindent

# forward direction for selection
kak-mark-point() {
  test ${CURSOR} -lt ${MARK} && zle exchange-point-and-mark
}
zle -N kak-mark-point

kak-repeat-find() {
  zle kak-reset-visual
  zle vi-repeat-find
}
zle -N kak-repeat-find

# swap case
kak-up-case() {
  C=${CURSOR}
  M=${MARK}
  zle vi-up-case
  zle kak-reset-visual
  MARK=${M}
  CURSOR=${C}
}
zle -N kak-up-case

kak-down-case() {
  C=${CURSOR}
  M=${MARK}
  zle vi-down-case
  zle kak-reset-visual
  MARK=${M}
  CURSOR=${C}
}
zle -N kak-down-case

# delete/yank/append/insert/paste
kak-delete() {
  zle vi-delete
  zle kak-reset-visual
}
zle -N kak-delete

kak-yank() {
  M=${MARK}
  zle vi-yank
  zle kak-reset-visual
  MARK=${M}
}
zle -N kak-yank

kak-add-eol() {
  zle kak-remove-visual
  zle vi-add-eol
}
zle -N kak-add-eol

kak-insert-bol() {
  zle kak-remove-visual
  zle vi-insert-bol
}
zle -N kak-insert-bol

kak-insert() {
  zle kak-remove-visual
  zle vi-insert
}
zle -N kak-insert

kak-add-next() {
  zle kak-remove-visual
  zle vi-add-next
}
zle -N kak-add-next

kak-put-before() {
  CS=${CURSOR}
  zle vi-put-before
  zle kak-reset-visual
  MARK=${CS}
}
zle -N kak-put-before

kak-put-after() {
  CS=${CURSOR}
  zle vi-put-after
  zle kak-reset-visual
  MARK=$(( ${CS} + 1 ))
}
zle -N kak-put-after

# line beginn/end
kak-beginning-of-line() {
  zle vi-beginning-of-line
  zle kak-reset-visual
}
zle -N kak-beginning-of-line

kak-first-non-blank() {
  zle vi-first-non-blank
  zle kak-reset-visual
}
zle -N kak-first-non-blank

kak-end-of-line() {
  zle vi-end-of-line
  zle kak-reset-visual
}
zle -N kak-end-of-line

# cursor char
kak-backward-char() {
  zle vi-backward-char
  zle kak-reset-visual
}
zle -N kak-backward-char

kak-forward-char() {
  zle vi-forward-char
  zle kak-reset-visual
}
zle -N kak-forward-char

# cursor word
kak-backward-word() {
  if test 1 -lt ${NUMERIC:-0}; then
    zle vi-backward-word -n $(( ${NUMERIC} - 1 ))
  fi
  zle kak-reset-visual
  zle vi-backward-word -n 1
  CS=${CURSOR}
  MS=${MARK}
  zle vi-forward-word -n 1
  test ${MS} -eq ${CURSOR} && MARK=$(( ${CURSOR} - 1 )) || MARK=${MS}
  CURSOR=${CS}
}
zle -N kak-backward-word

kak-backward-blank-word() {
  if test 1 -lt ${NUMERIC:-0}; then
    zle vi-backward-blank-word -n $(( ${NUMERIC} - 1 ))
  fi
  zle kak-reset-visual
  zle vi-backward-blank-word -n 1
  CS=${CURSOR}
  MS=${MARK}
  zle vi-forward-blank-word -n 1
  test ${MS} -eq ${CURSOR} && MARK=$(( ${CURSOR} - 1 )) || MARK=${MS}
  CURSOR=${CS}
}
zle -N kak-backward-blank-word

kak-forward-word-end() {
  CS=${CURSOR}
  if test 1 -lt ${NUMERIC:-0}; then
    zle select-in-word -n 1
    if test ${CS} -eq ${CURSOR}; then
      zle vi-forward-word-end -n $(( ${NUMERIC} - 1 ))
    else
      test 2 -lt ${NUMERIC} && zle vi-forward-word-end -n $(( ${NUMERIC} -2 ))
    fi
    CS=${CURSOR}
  fi
  zle kak-reset-visual
  zle select-in-word -n 1
  if test ${CS} -eq ${CURSOR}; then
    zle kak-reset-visual
    zle vi-forward-word-end -n 1
    MARK=$(( ${CS} + 1 ))
  else
    MARK=${CS}
  fi
}
zle -N kak-forward-word-end

kak-forward-blank-word-end() {
  CS=${CURSOR}
  zle vi-forward-blank-word -n 1
  test $(( ${CS} + 2 )) -eq ${CURSOR} && CURSOR=$(( ${CS} + 1 )) || CURSOR=${CS}
  if test 1 -lt ${NUMERIC:-0}; then
    zle vi-forward-blank-word-end -n $(( ${NUMERIC} - 1 ))
    CURSOR=$(( ${CURSOR} + 1 ))
  fi
  zle kak-reset-visual
  zle vi-forward-blank-word-end -n 1
}
zle -N kak-forward-blank-word-end

kak-sel-forward-word() {
  CS=${CURSOR}
  zle vi-forward-word -n 1
  test $(( ${CS} + 1 )) = ${CURSOR} && zle vi-forward-word -n 1
  if test 1 -lt ${NUMERIC:-0}; then
    zle vi-forward-word -n $(( ${NUMERIC} - 1 ))
  fi
  zle vi-backward-char -n 1
}
zle -N kak-sel-forward-word

kak-sel-forward-blank-word() {
  CS=${CURSOR}
  zle vi-forward-blank-word -n 1
  test $(( ${CS} + 1 )) = ${CURSOR} && zle vi-forward-blank-word -n 1
  if test 1 -lt ${NUMERIC:-0}; then
    zle vi-forward-blank-word -n $(( ${NUMERIC} - 1 ))
  fi
  zle vi-backward-char -n 1
}
zle -N kak-sel-forward-blank-word

kak-forward-word() {
  CS=${CURSOR}
  zle kak-reset-visual
  zle vi-forward-word -n 1
  CE=${CURSOR}
  if test 1 -lt ${NUMERIC:-0}; then
    test 2 -lt ${NUMERIC} && zle vi-forward-word -n $(( ${NUMERIC} - 2 ))
    zle kak-reset-visual
    zle vi-forward-word -n 1
  fi
  if test $(( ${CS} + 1 )) = ${CE}; then
    zle kak-reset-visual
    zle vi-forward-word -n 1
  fi
  zle vi-backward-char -n 1
}
zle -N kak-forward-word

kak-forward-blank-word() {
  CS=${CURSOR}
  zle kak-reset-visual
  zle vi-forward-blank-word -n 1
  CE=${CURSOR}
  if test 1 -lt ${NUMERIC:-0}; then
    test 2 -lt ${NUMERIC} && zle vi-forward-blank-word -n $(( ${NUMERIC} - 2 ))
    zle kak-reset-visual
    zle vi-forward-blank-word -n 1
  fi
  if test $(( ${CS} + 1 )) = ${CE}; then
    zle kak-reset-visual
    zle vi-forward-blank-word -n 1
  fi
  zle vi-backward-char -n 1
}
zle -N kak-forward-blank-word

# bindkey - vicmd
bindkey -N vicmd
bindkey -M vicmd -R 0-9 digit-argument
bindkey -M vicmd "^[" vi-cmd-mode
bindkey -M vicmd "^L" clear-screen
bindkey -M vicmd "^M" kak-accept-line
bindkey -M vicmd "^J" kak-accept-line

bindkey -M vicmd "<" kak-unindent
bindkey -M vicmd ">" kak-indent
bindkey -M vicmd ";" kak-reset-visual
bindkey -M vicmd "\e;" exchange-point-and-mark
bindkey -M vicmd "\e:" kak-mark-point
bindkey -M vicmd "." vi-repeat-change
bindkey -M vicmd "\e." kak-repeat-find
bindkey -M vicmd "~" kak-up-case
bindkey -M vicmd "\`" kak-down-case
bindkey -M vicmd "A" kak-add-eol
bindkey -M vicmd "I" kak-insert-bol
bindkey -M vicmd "\eJ" vi-join
bindkey -M vicmd "O" vi-open-line-above
bindkey -M vicmd "P" kak-put-before
bindkey -M vicmd "U" redo
bindkey -M vicmd "X" visual-line-mode
bindkey -M vicmd "a" kak-add-next
bindkey -M vicmd "c" vi-change
bindkey -M vicmd "d" kak-delete
bindkey -M vicmd "f" vi-find-next-char
bindkey -M vicmd "\ef" vi-find-prev-char
bindkey -M vicmd "i" kak-insert
bindkey -M vicmd "o" vi-open-line-below
bindkey -M vicmd "p" kak-put-after
bindkey -M vicmd "r" vi-replace-chars
bindkey -M vicmd "t" vi-find-next-char-skip
bindkey -M vicmd "\et" vi-find-prev-char-skip
bindkey -M vicmd "u" undo
bindkey -M vicmd "x" visual-line-mode
bindkey -M vicmd "y" kak-yank

bindkey -M vicmd "k" kak-up-line
bindkey -M vicmd "j" kak-down-line

bindkey -M vicmd "H" vi-backward-char
bindkey -M vicmd "h" kak-backward-char
bindkey -M vicmd "\eh" vi-beginning-of-line
bindkey -M vicmd "L" vi-forward-char
bindkey -M vicmd "l" kak-forward-char
bindkey -M vicmd "\el" vi-end-of-line

bindkey -M viins "^P" up-line-or-search
bindkey -M viins "^N" down-line-or-search

bindkey -M vicmd "Gh" vi-beginning-of-line
bindkey -M vicmd "gh" kak-beginning-of-line
bindkey -M vicmd "gi" kak-first-non-blank
bindkey -M vicmd "Gl" vi-end-of-line
bindkey -M vicmd "gl" kak-end-of-line

bindkey -M vicmd "q" kak-backward-word
bindkey -M vicmd "Q" vi-backward-word
bindkey -M vicmd "\eq" kak-backward-blank-word
bindkey -M vicmd "\eQ" vi-backward-blank-word
bindkey -M vicmd "e" kak-forward-word-end
bindkey -M vicmd "E" vi-forward-word-end
bindkey -M vicmd "\ee" kak-forward-blank-word-end
bindkey -M vicmd "\eE" vi-forward-blank-word-end
bindkey -M vicmd "w" kak-forward-word
bindkey -M vicmd "W" kak-sel-forward-word
bindkey -M vicmd "\ew" kak-forward-blank-word
bindkey -M vicmd "\eW" kak-sel-forward-blank-word

# edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line

kak-edit-command-line() {
  zle kak-remove-visual
  zle edit-command-line
}
zle -N kak-edit-command-line
bindkey -M vicmd '^V' kak-edit-command-line


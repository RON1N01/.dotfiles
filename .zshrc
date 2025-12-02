# Enable vi keybindings
bindkey -v

# Map 'jj' in insert mode to escape to normal mode
bindkey -M viins 'jj' vi-cmd-mode

# Smarter history search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind arrow keys in insert mode
bindkey -M viins '^[[A' up-line-or-beginning-search   # Up arrow
bindkey -M viins '^[[B' down-line-or-beginning-search # Down arrow

# Bind arrow keys in normal mode too
bindkey -M vicmd '^[[A' up-line-or-beginning-search
bindkey -M vicmd '^[[B' down-line-or-beginning-search

# Change cursor shape based on vi mode
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Normal mode: block cursor
    echo -ne '\e[1 q'
  else
    # Insert mode: beam cursor
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  # Start in insert mode cursor
  echo -ne '\e[5 q'
}
zle -N zle-line-init

# When running a command, reset cursor to terminal default
function preexec {
  echo -ne '\e[0 q'
}

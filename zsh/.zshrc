pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

pathadd /opt/nvim-linux64/bin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"


bindkey -v

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/custom_aliases.zsh"

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
# plug "zap-zsh/zap-prompt"
# plug "zap-zsh/fzf"
# plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
plug "romkatv/powerlevel10k"

# plugins config
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"

# keybinds
bindkey '^ ' autosuggest-accept
bindkey '^R' history-incremental-search-backward
bindkey '^O' accept-line-and-down-history
bindkey '^[[1;5A' history-search-backward
bindkey '^[[1;5B' history-search-forward

export PATH="$HOME/.local/bin:/usr/local/go/bin":$PATH

if command -v go &> /dev/null; then
  export PATH=$PATH:$(go env GOPATH)/bin
fi

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

# Replaces autojump (upstream's last release was 22.5.1; it also paid a python
# startup cost on every prompt). History was carried over with:
#   zoxide import autojump --merge
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

export EDITOR=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Must stay below the p10k source above -- direnv hooks precmd, and wants to run
# after anything that sets up the prompt.
if command -v direnv &> /dev/null; then
  # Default logging prints every var it exports on each cd, which is a lot of
  # noise for a venv. Empty string keeps errors, drops the routine chatter.
  export DIRENV_LOG_FORMAT=""
  eval "$(direnv hook zsh)"
fi

# fzf: CTRL-T paths, CTRL-R history, ALT-C cd into a dir under $PWD.
# Sourced down here on purpose so fzf's CTRL-R wins over the binding above.
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)

  export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border"
  if command -v fd &> /dev/null; then
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
  fi
  export FZF_ALT_C_OPTS="--preview 'ls -la --color=always {}'"
fi

# One picker over both sources: dirs already visited (frecency-ordered, anywhere
# on disk) followed by everything under $PWD. zoxide alone can't offer the
# latter -- its database only ever holds directories you've actually cd'd into.
zf() {
  local dir
  dir=$(
    {
      command -v zoxide &> /dev/null && zoxide query -l
      if command -v fd &> /dev/null; then
        fd --type d --hidden --exclude .git . "$PWD"
      else
        find "$PWD" -name .git -prune -o -type d -print 2> /dev/null
      fi
    } | awk '!seen[$0]++' |
      fzf --prompt='cd > ' --preview 'ls -la --color=always {}'
  ) && cd "$dir"
}

# Widget rather than `bindkey -s`, so pressing it mid-command doesn't shove
# text into whatever you were already typing.
_zf_widget() {
  zf < /dev/tty
  zle reset-prompt
}
zle -N _zf_widget
bindkey '^F' _zf_widget

# Cheatsheet, in the spirit of kitty's own shortcut window. Edit the list at
# ~/.config/zsh/cheatsheet.txt; `#` starts a section, `|` splits key from
# description. Paged with -F so short output just prints without swallowing
# the screen, and -X so it stays on screen after quitting.
help() {
  local sheet=${ZDOTDIR:-$HOME/.config/zsh}/cheatsheet.txt
  if [[ ! -r $sheet ]]; then
    print -u2 "help: no cheatsheet at $sheet"
    return 1
  fi
  awk -F' *\\| *' '
    /^#/ { printf "\n\033[1;36m%s\033[0m\n", substr($0, 3); next }
    /^$/ { next }
         { printf "  \033[1;33m%-20s\033[0m %s\n", $1, $2 }
  ' "$sheet" | less -FRX
}

# `?` on an empty prompt opens it too. A function named `?` is impossible --
# zsh glob-expands the command word, so in a directory holding any one-char
# file, `?` would run *that file*. Binding the key sidesteps the parser
# entirely, and only fires on an empty line, so `?` still types normally.
_help_widget() {
  if [[ -z $BUFFER ]]; then
    BUFFER='help'
    zle accept-line
  else
    zle self-insert
  fi
}
zle -N _help_widget
bindkey -M viins '?' _help_widget

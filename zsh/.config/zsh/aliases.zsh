#!/bin/bash

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

alias m="git checkout master"

alias wd='function _go_to_working_dir() { cd "$1" && source venv/bin/activate; }; _go_to_working_dir'

# fix ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"


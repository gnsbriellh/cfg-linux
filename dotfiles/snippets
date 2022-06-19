# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#exit terminal
alias e='exit'

#clear terminal
alias c='clear' 

#view commands history.
alias h='history' 

#Use 'update' to update the repository
alias update='sudo apt update -y' 

#Use 'upgrade' to update the system and apps
alias upgrade='sudo apt upgrade -y' 

alias ..='cd ..' #Go back one folder

# enable color support and shorten some commands of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -a --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


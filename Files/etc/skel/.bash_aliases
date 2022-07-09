# Alias definitions.

    alias e='exit'      # Exit Terminal
    alias c='clear'     # Clear Terminal
    alias h='history'   # View Commands History.
    alias ..='cd ..'    # Go back One Folder

# enable color support and shorten some commands of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -la --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
    alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


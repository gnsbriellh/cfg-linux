#        _______    ______    ______   __    __  _______    ______  
#       |       \  /      \  /      \ |  \  |  \|       \  /      \ 
#       | $$$$$$$\|  $$$$$$\|  $$$$$$\| $$  | $$| $$$$$$$\|  $$$$$$\
#       | $$__/ $$| $$__| $$| $$___\$$| $$__| $$| $$__| $$| $$   \$$
#       | $$    $$| $$    $$ \$$    \ | $$    $$| $$    $$| $$      
#       | $$$$$$$\| $$$$$$$$ _\$$$$$$\| $$$$$$$$| $$$$$$$\| $$   __ 
#    __ | $$__/ $$| $$  | $$|  \__| $$| $$  | $$| $$  | $$| $$__/  \
#   |  \| $$    $$| $$  | $$ \$$    $$| $$  | $$| $$  | $$ \$$    $$
#    \$$ \$$$$$$$  \$$   \$$  \$$$$$$  \$$   \$$ \$$   \$$  \$$$$$$ 
#                                                                   
#                                                                   
#                                                                   

## If not running interactively, don't do anything ##
    case $- in
        *i*) ;;
        *) return;;
    esac

## set variable identifying the chroot you work in (used in the prompt below) ##
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then

        debian_chroot=$(cat /etc/debian_chroot)

    fi

## make less more friendly for non-text input files, see lesspipe(1) ##
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## History Customization ##
    HISTCONTROL=ignoredups
    HISTSIZE=10000
    HISTFILESIZE=10000
    shopt -s histappend
    shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color) #
    case "$TERM" in
    
        xterm-color|*-256color) color_prompt=yes;;

    esac

    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then

            color_prompt=yes

        else

            color_prompt=

        fi
    fi

## Tab Suggestions, Completions, Aliases and Source Files ##

    ## This will read aliases from .bash_aliases ##
    if [ -f ~/.bash_aliases ] ; then

        . ~/.bash_aliases

    fi

    # Bash
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then

            . /usr/share/bash-completion/bash_completion

        elif [ -f /etc/bash_completion ]; then

            . /etc/bash_completion

        fi
    fi

    # Git
        ## This will read a file that shows the current git branch and another that allows git completions on the terminal ##
    if [ -f ~/.config/bash/git-prompt.sh ] && [ -f ~/.config/bash/git-completion.bash ]  ; then

        source ~/.config/bash/git-prompt.sh
        source ~/.config/bash/git-completion.bash

    fi

## Custom PS1 ##

    if [ "$color_prompt" = yes ] && [ ! "${EUID:-$(id -u)}" -eq 0 ]; then
        PS1='\
\[\e[0;37m\]\n\[\e[0m\]\
${debian_chroot:+($debian_chroot)}\
\[\e[0;37m\][\[\e[0m\]\
\[\e[2;34m\]\D{%d/%b}\[\e[0m\]\
\[\e[2;34m\] | \[\e[0m\]\
\[\e[2;34m\]\@\[\e[0m\]\
\[\e[0;37m\]]\[\e[0m\]\
\[\e[0;37m\] - \[\e[0m\]\
\[\e[0;37m\](\[\e[0m\]\
\[\e[1;32m\]\w\[\e[0m\]\
\[\e[0;37m\])\[\e[0m\]\
\[\e[1;3;33m\]$(__git_ps1 " שׂ (%s)")\[\e[0m\]\
\[\e[0;37m\]\n\[\e[0m\]\
\[\e[**m\] ↪ \[\e[0m\]\
\[\e[**m\][\[\e[0m\]\
\[\e[1;35m\]\$\[\e[0m\]\
\[\e[**m\]]\[\e[0m\]\
\[\e[1;32m\]\u\[\e[0m\]\
\[\e[**m\]:\[\e[0m\]\
\[\e[**m\] » \[\e[0m\]\
'
    elif [ "$color_prompt" = yes ] && [ "${EUID:-$(id -u)}" -eq 0 ]; then
        PS1='\
\[\e[0;37m\]\n\[\e[0m\]\
${debian_chroot:+($debian_chroot)}\
\[\e[0;37m\][\[\e[0m\]\
\[\e[2;34m\]\D{%d/%b}\[\e[0m\]\
\[\e[2;34m\] | \[\e[0m\]\
\[\e[2;34m\]\@\[\e[0m\]\
\[\e[0;37m\]]\[\e[0m\]\
\[\e[0;37m\] - \[\e[0m\]\
\[\e[0;37m\](\[\e[0m\]\
\[\e[1;32m\]\w\[\e[0m\]\
\[\e[0;37m\])\[\e[0m\]\
\[\e[1;3;33m\]$(__git_ps1 " ▸ (%s)")\[\e[0m\]\
\[\e[0;37m\]\n\[\e[0m\]\
\[\e[**m\] ↪ \[\e[0m\]\
\[\e[**m\][\[\e[0m\]\
\[\e[1;5;31m\]\$\[\e[0m\]\
\[\e[**m\]]\[\e[0m\]\
\[\e[1;32m\]\u\[\e[0m\]\
\[\e[**m\]:\[\e[0m\]\
\[\e[**m\] » \[\e[0m\]\
'
    else

    PS1='${debian_chroot:+($debian_chroot)}[\D{%d/%b} | \@ ] - (\w)\n ↪[\$]\u: » '

    fi

    unset color_prompt force_color_prompt

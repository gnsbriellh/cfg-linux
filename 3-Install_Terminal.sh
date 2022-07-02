#!/bin/bash

## Move dotfiles to their propper location ##

    # Move only if user is not root #
        if [ ! "${EUID:-$(id -u)}" -eq 0 ] ; then

            #Git
                wget -c -P $PWD/dotfiles/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
                wget -c -P $PWD/dotfiles/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

            #Root
                sudo cp     $PWD/dotfiles/.bashrc               /root/.bashrc -v
                sudo cp     $PWD/dotfiles/.bash_aliases         /root/.bash_aliases -v
                sudo mkdir  /root/.config/bash/                 -p -v
                sudo cp     $PWD/dotfiles/git-prompt.sh         /root/.config/bash/.git-prompt.sh -v
                sudo cp     $PWD/dotfiles/git-completion.bash   /root/.config/bash/.git-completion.bash -v

            #User
                cp          $PWD/dotfiles/.bashrc               ~/ -v
                cp          $PWD/dotfiles/.bash_aliases         ~/ -v
                mkdir       ~/.config/bash/                     -p -v
                cp          $PWD/dotfiles/git-prompt.sh         ~/.config/bash/.git-prompt.sh -v
                cp          $PWD/dotfiles/git-completion.bash   ~/.config/bash/.git-completion.bash -v

            # Open New Bash Session #
                bash

        else

            # Warn User that it is logged as root #
                echo "One shouldn't be logged as root to perform this operation. Try again..."

        fi


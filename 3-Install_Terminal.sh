#!/bin/bash

##  ##
if [ ! "${EUID:-$(id -u)}" -eq 0 ] ; then

	#Git
	sudo wget -c -P $PWD/dotfiles/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

	#Root
	sudo cp $PWD/dotfiles/.bashrc 		/root/.bashrc -v
	sudo cp $PWD/dotfiles/.bash_aliases /root/.bash_aliases -v
	sudo mkdir /root/.config/bash/ -p -v
	sudo cp $PWD/dotfiles/git-prompt.sh /root/.config/bash/git-prompt.sh -v

	#User
	cp $PWD/dotfiles/.bashrc 		~/ -v
	cp $PWD/dotfiles/.bash_aliases 	~/ -v
	mkdir ~/.config/bash/ -p -v
	sudo cp $PWD/dotfiles/git-prompt.sh ~/.config/bash/git-prompt.sh -v

else

	echo "One shouldn't be logged as root to perform this operation. Try again..."

fi

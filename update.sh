#!/bin/bash

## Customize Terminal ##

	BACKUP_FOLDER="/home/$USER/Documents/DotFilesBackup"
	mkdir $BACKUP_FOLDER -p

	cp /home/$USER/.bashrc $BACKUP_FOLDER/.bashrc.user-backup
	cp $PWD/dotfiles/.bashrc-user /home/$USER/.bashrc
	cp $PWD/dotfiles/snippets /home/$USER/.bash_aliases

	sudo cp /root/.bashrc $BACKUP_FOLDER/.bashrc.root-backup
	sudo cp $PWD/dotfiles/.bashrc-root /root/.bashrc
	sudo cp $PWD/dotfiles/snippets /root/.bash_aliases

	sudo cp /etc/skel/.bashrc $BACKUP_FOLDER/.bashrc.skel-backup
	sudo cp $PWD/dotfiles/.bashrc-user /etc/skel/.bashrc
	sudo cp $PWD/dotfiles/snippets /etc/skel/.bash_aliases

## Update the System ##

	sudo pacman -Syu 		--noconfirm

## Install Softwares (Pacman) ##

	sudo pacman -S git 		--noconfirm
	sudo pacman -S virtualbox 	--noconfirm
	sudo pacman -S piper 		--noconfirm
	sudo pacman -S gparted 		--noconfirm
	sudo pacman -S steam 		--noconfirm
	sudo pacman -S discord 		--noconfirm
	sudo pacman -S gnome-tweaks 	--noconfirm
	sudo pacman -S thunderbird	--noconfirm
	sudo pacman -S snapd 		--noconfirm

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm install 16 ; nvm use 16

## Install Softwares (AUR) ##

	#Google-Chrome
		git clone https://aur.archlinux.org/google-chrome.git
		sudo chmod 777 google-chrome ; cd google-chrome ; makepkg -s
		mv *.deb google_chrome.deb ; mv *.zst google_chrome.zst
		sudo pacman -U google_chrome.zst --noconfirm		

## Install Softwares (Snap) ##

	sudo snap install code
	sudo snap install spotify
	sudo snap install telegram-desktop

## Install Softwares (Flatpak) ##

## Install Extentions (Gnome Desktop Only) ##

	xdg-open https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep
	xdg-open https://extensions.gnome.org/extension/7/removable-drive-menu/
	xdg-open https://extensions.gnome.org/extension/906/sound-output-device-chooser/
	xdg-open https://extensions.gnome.org/extension/19/user-themes/

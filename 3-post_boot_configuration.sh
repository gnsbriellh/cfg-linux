#!/bin/zsh

~/.config/prompt/git-prompt.sh



## Download and Install a New Theme ##

	#Theme only (No Sys Icons or Mouse Icons)
		git clone https://github.com/daniruiz/flat-remix-gtk.git
		sudo mv $PWD/flat-remix-gtk/themes/Flat-Remix-GTK-Grey-Dark /home/$USER/.themes/
		sudo mv $PWD/flat-remix-gtk/themes/Flat-Remix-LibAdwaita-Grey-Dark/* /home/$USER/.config/gtk-4.0/
		gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Grey-Dark"


## Set Current SHELL to BASH ##
	
	#

## Update the System ##

	sudo pacman -Syu 			--noconfirm

## Install Softwares (Pacman) ##

	sudo pacman -S git 					--noconfirm ;
	sudo pacman -S virtualbox 			--noconfirm ;
	sudo pacman -S piper 				--noconfirm ;
	sudo pacman -S gparted 				--noconfirm ;
	sudo pacman -S steam 				--noconfirm ;
	sudo pacman -S discord 				--noconfirm ;
	sudo pacman -S gnome-tweaks 		--noconfirm ;
	sudo pacman -S thunderbird 			--noconfirm ;
	sudo pacman -S snapd 				--noconfirm ;
	sudo pacman -S chromium				--noconfirm ;
	sudo pacman -S telegram-desktop 	--noconfirm ;
	sudo pacman -S neofetch				--noconfirm ;
	sudo pacman -S fragments			--noconfirm ;
	sudo pacman -S gedit				--noconfirm ; 

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm install 16 ; nvm use 16

## Install Softwares (AUR) ##

	#Google-Chrome
		#git clone https://aur.archlinux.org/google-chrome.git
		#sudo chmod 777 google-chrome ; cd google-chrome ; makepkg -s
		#mv *.deb google_chrome.deb ; mv *.zst google_chrome.zst
		#sudo pacman -U google_chrome.zst --noconfirm		

## Install Softwares (Snap) ##

	sudo ln -s /var/lib/snapd/snap /snap ;
	sudo snap install code --classic
	sudo snap install spotify

## Install Softwares (Flatpak) ##

	#

## Install Extentions (Gnome Desktop Only) ##

	xdg-open https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep
	xdg-open https://extensions.gnome.org/extension/7/removable-drive-menu/
	xdg-open https://extensions.gnome.org/extension/906/sound-output-device-chooser/
	xdg-open https://extensions.gnome.org/extension/19/user-themes/

#!/bin/bash

## Update Repository ##

	sudo pacman -Syy

## Softwares ##

	# Firewall #
	sudo pacman -S ufw							--noconfirm # Firewall
	sudo enable ufw
	sudo systemctl enable ufw.service

	# Pacman #
	sudo pacman -S wget							--noconfirm # wget
	sudo pacman -S curl							--noconfirm # curl
	sudo pacman -S firefox						--noconfirm # Web Browser
	sudo pacman -S virtualbox					--noconfirm # Virtualbox...
	sudo pacman -S piper						--noconfirm # Mouse Software
	sudo pacman -S steam						--noconfirm # Steam ...
	sudo pacman -S noto-fonts-emoji				--noconfirm # Fix Steam Fonts
	sudo pacman -S lib32-fontconfig				--noconfirm # Fix Steam Fonts
	sudo pacman -S ttf-liberation				--noconfirm # Fix Steam Fonts
	sudo pacman -S wqy-zenhei					--noconfirm # Fix Steam Fonts
	sudo pacman -S lutris						--noconfirm # Video Game Manager
	sudo pacman -S discord						--noconfirm # Discord...
	sudo pacman -S thunderbird					--noconfirm # E-mail Client
	sudo pacman -S telegram-desktop				--noconfirm # Telegram...
	sudo pacman -S qbittorrent					--noconfirm # Download Torrents
	sudo pacman -S latte-dock					--noconfirm # Add New Dock and Panel
	sudo pacman -S neofetch						--noconfirm # Display OS Details
	sudo pacman -S htop							--noconfirm # System Monitor
	sudo pacman -S btop							--noconfirm # System Monitor

	# KDE Applications #
	sudo pacman -S ark                          --noconfirm # Archiving Tool
	sudo pacman -S dolphin                      --noconfirm # File Manager
	sudo pacman -S dolphin-plugins              --noconfirm # File Manager - Plugins
	sudo pacman -S gwenview                     --noconfirm # Image Viewer
	sudo pacman -S ffmpegthumbs                 --noconfirm # Thumbnails for Videos
	sudo pacman -S kdegraphics-thumbnailers     --noconfirm # Thumbnails for Files
	sudo pacman -S kdesdk-thumbnailers          --noconfirm # Thumbnail - Plugins
	sudo pacman -S kate                         --noconfirm # Text Editor
	sudo pacman -S kcalc                        --noconfirm # Calculator
	sudo pacman -S kcolorchooser                --noconfirm # Color Picker
	sudo pacman -S okular                       --noconfirm # Document Viewer
	sudo pacman -S print-manager                --noconfirm # Manage Printers
	sudo pacman -S skanlite                     --noconfirm # Printer Scanner
	sudo pacman -S spectacle                    --noconfirm # Screenshot Tool
	sudo pacman -S partitionmanager             --noconfirm # Partition Manger Utility
	sudo pacman -S kde-gtk-config               --noconfirm # Syncs KDE settings to GTK applications
	sudo pacman -S packagekit-qt5               --noconfirm # Fix for Discover
	sudo pacman -S alsa-utils                   --noconfirm # Fix for Audio Issues

## Arch User Repository ##

	mkdir $PWD/AUR ; cd AUR

	# Spotify #
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
	git clone https://aur.archlinux.org/spotify.git
	cd spotify ; makepkg -si ; cd ..

	# VSCode #
	git clone https://aur.archlinux.org/visual-studio-code-bin.git
	cd visual-studio-code-bin ; makepkg -si ; cd ..

	# Google Chrome #
	#git clone https://aur.archlinux.org/google-chrome.git
	#cd google-chrome ; makepkg -si ; cd ..

	cd ..

## Curl ##

	# NVM #
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm install 16 ; nvm use 16

## Prompt to Install .bashrc ##

	while true; do
		read -p "Install .bashrc and .bash_aliases ? [Y/n] " yn
		case $yn in
			[Yy]* ) bash "$PWD/3-Install_(Terminal).sh"; break;;
			[Nn]* ) echo "Answer: 'No'"; break;;
			* ) echo "Please answer with Yy[es] or Nn[o].";;
		esac
	done






#!/bin/bash

## Update Repository ##
sudo apt update -y ; sudo apt upgrade -y ;

## Download/Install Repository Apps ##
sudo apt install git -y
sudo apt install virtualbox -y
sudo apt install piper -y
sudo apt install gparted -y
sudo apt install steam -y
sudo apt install code -y
sudo apt install gnome-tweaks -y
sudo apt install thunderbird -y
sudo apt install python3 python3-venv python3-pip -y
#sudo apt install ubuntu-restricted-extras -y

## Download/Install Snapd Apps ##
sudo apt install snapd -y
sudo snap install spotify
sudo snap install telegram-desktop

## Backup and Swap .bachrc file (New,Current and Root Users) and insert snippets file, for the terminal ##

BACKUP_FOLDER="/home/$USER/Documents/DotFilesBackup"
mkdir $BACKUP_FOLDER

cp /home/$USER/.bashrc $BACKUP_FOLDER/.bashrc.user-backup
cp $PWD/dotfiles/.bashrc-user /home/$USER/.bashrc
cp $PWD/dotfiles/snippets /home/$USER/.bash_aliases

sudo cp /root/.bashrc $BACKUP_FOLDER/.bashrc.root-backup
sudo cp $PWD/dotfiles/.bashrc-root /root/.bashrc
sudo cp $PWD/dotfiles/snippets /root/.bash_aliases

sudo cp /etc/skel/.bashrc $BACKUP_FOLDER/.bashrc.skel-backup
sudo cp $PWD/dotfiles/.bashrc-user /etc/skel/.bashrc
sudo cp $PWD/dotfiles/snippets /etc/skel/.bash_aliases

## Download/Install External Apps ##
DEST_DIR="/home/$USER/Downloads/TempFolder"
mkdir $DEST_DIR ; cd $DEST_DIR ;

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i *.deb

## Download/Install NVM ##

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 16

nvm use 16

## Update Repository again just to make sure they're up to date ##
sudo apt update -y ; sudo apt upgrade -y ;

## Remove TempFolder Folder ##
yes | rm -r $DEST_DIR

## Open Extentions URL ##
echo Press [Enter] to open extentions URL
read Enter
sensible-browser \
https://extensions.gnome.org/extension/7/removable-drive-menu/ \
https://extensions.gnome.org/extension/906/sound-output-device-chooser/


#!/bin/bash

## System Configuration ##

        # Config Time Zone #
        ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime -v

        # Cofig Hardware Clock #
        hwclock --systohc -v

        # Config Locale #
        sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
        locale-gen
        echo "LANG=en_US.UTF-8" >> /etc/locale.conf

        # Config Hostname #
        echo "gnsbriellh-desktop" >> /etc/hostname

        # Config Pretty Hostname #
        PRETTY_HOSTNAME="Gabriel's Desktop"
        ICON_NAME="computer"
        CHASSIS="desktop"
        DEPLOYMENT="production"

        echo PRETTY_HOSTNAME='"'$PRETTY_HOSTNAME'"' >> /etc/machine-info
        echo ICON_NAME=$ICON_NAME >> /etc/machine-info
        echo CHASSIS=$CHASSIS >> /etc/machine-info
        echo DEPLOYMENT=$DEPLOYMENT >> /etc/machine-info

        # Config Hosts #
        echo "127.0.0.1    localhost" >> /etc/hosts
        echo "::1          localhost" >> /etc/hosts
        echo "127.0.1.1    gnsbriellh-desktop.localdomain gnsbriellh-desktop" >> /etc/hosts

        # Configuring Keyboar Layout (Console) #
        echo "KEYMAP=us-acentos" >> /etc/vconsole.conf

        # Add Multilib to pacman #
        echo "[multilib]" >> /etc/pacman.conf
        echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

# Necessary Packages #

        pacman -Sy                              --noconfirm
        pacman -S man-db                        --noconfirm
        pacman -S man-pages                     --noconfirm
        pacman -S dosfstools                    --noconfirm
        pacman -S os-prober                     --noconfirm
        pacman -S mtools                        --noconfirm
        pacman -S wpa_supplicant                --noconfirm
        pacman -S wireless_tools                --noconfirm
        pacman -S dialog                        --noconfirm
        pacman -S networkmanager                --noconfirm
        pacman -S network-manager-applet        --noconfirm

        systemctl enable NetworkManager.service

## Boot Manager ##

        # GRUB #
        pacman -S grub                          --noconfirm
        pacman -S efibootmgr                    --noconfirm
        pacman -S intel-ucode                   --noconfirm

        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
        sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0.1/g' /etc/default/grub
        grub-mkconfig -o /boot/grub/grub.cfg

## GPU & Video Drivers ##

        # AMD #
        pacman -S xorg                          --noconfirm
        pacman -S mesa                          --noconfirm
        pacman -S lib32-mesa                    --noconfirm
        pacman -S xf86-video-amdgpu             --noconfirm
        pacman -S vulkan-radeon                 --noconfirm
        pacman -S lib32-vulkan-radeon           --noconfirm
        pacman -S libva-mesa-driver             --noconfirm
        pacman -S lib32-libva-mesa-driver       --noconfirm
        pacman -S mesa-vdpau                    --noconfirm
        pacman -S lib32-mesa-vdpau              --noconfirm

## Display Manager ##

        # KDE-Plasma #
        pacman -S sddm                          --noconfirm
        systemctl enable sddm.service

        # Gnome #
        #pacman -S gdm
        #systemctl enable gdm.service

## Desktop Environment ##

        # Plasma KDE #
        pacman -S plasma                        --noconfirm
        pacman -S plasma-desktop                --noconfirm
        pacman -S konsole                       --noconfirm

        # Gnome #
        #pacman -S gnome
        #pacman -S gnome-terminal
        #pacman -S gnome-extra

## Create User ##

        SET_USER="gnsbriellh"

        useradd -m -G wheel -s /bin/bash $SET_USER

        echo "Set password for $SET_USER"
        passwd gnsbriellh

        echo "Set password for root user"
        passwd root

        sleep 2 ; echo "Visudo will now open in 7s..." ; sleep 7
        EDITOR=nano visudo

## Done... ##

        echo "Installation Completed !"

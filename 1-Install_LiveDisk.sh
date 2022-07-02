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
        echo "127.0.0.1     localhost" >> /etc/hosts
        echo "::1           localhost" >> /etc/hosts
        echo "127.0.1.1     gnsbriellh-desktop.localdomain gnsbriellh-desktop" >> /etc/hosts

    # Configuring Keyboard Layout (Console) #
        echo "KEYMAP=us-acentos" >> /etc/vconsole.conf

    # Add Multilib to pacman #
        echo "[multilib]" >> /etc/pacman.conf
        echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

# Necessary Packages #

    # Installation #
        pacman -Sy                          --noconfirm # Update repository;
        pacman -S man-db                    --noconfirm # Manual - Database;
        pacman -S man-pages                 --noconfirm # Manual - Pages;
        pacman -S dosfstools                --noconfirm # FAT filesystem formater;
        pacman -S os-prober                 --noconfirm # Boot to other operational systems from GRUB;
        pacman -S mtools                    --noconfirm # Utilities to access MS-DOS disks;
        pacman -S wpa_supplicant            --noconfirm # WPA Utility;
        pacman -S wireless_tools            --noconfirm # Utilities to access wireless networks;
        pacman -S dialog                    --noconfirm # Conect to a wireless network with a graphical interface;
        pacman -S networkmanager            --noconfirm # Detect and Connect to the Network;
        pacman -S network-manager-applet    --noconfirm # System tray icon for Network Manager;

    # Enable Services #
        systemctl enable NetworkManager.service

## Boot Manager ##

    # GRUB #
        pacman -S grub          --noconfirm # Bootloader;
        pacman -S efibootmgr    --noconfirm # EFI Bootmanager;
        pacman -S intel-ucode   --noconfirm # Intel Microcode Update Utility;

        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
        sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0.1/g' /etc/default/grub
        grub-mkconfig -o /boot/grub/grub.cfg

## GPU & Video Drivers ##

    # AMD #
        pacman -S xorg                      --noconfirm # Display Server;
        pacman -S mesa                      --noconfirm # Open-source OpenGL and GPU Drivers Colletion;
        pacman -S lib32-mesa                --noconfirm # Open-source OpenGL and GPU Drivers Colletion (32bit Support);
        pacman -S xf86-video-amdgpu         --noconfirm # AMD Radeon GPU - DDX Driver (Provides 2D acceleration in Xorg);
        pacman -S vulkan-radeon             --noconfirm # AMD Radeon GPU - Vulkan Support;
        pacman -S lib32-vulkan-radeon       --noconfirm # AMD Radeon GPU - Vulkan Support (32bit Support);
        pacman -S libva-mesa-driver         --noconfirm # Support for accelerated video decoding - VA-API;
        pacman -S lib32-libva-mesa-driver   --noconfirm # Support for accelerated video decoding - VA-API (32bit Support);
        pacman -S mesa-vdpau                --noconfirm # Support for accelerated video decoding - VDPAU;
        pacman -S lib32-mesa-vdpau          --noconfirm # Support for accelerated video decoding - VDPAU (32bit Support);

## Display Manager ##

    # SDDM #
        pacman -S sddm                  --noconfirm # KDE Display Manager;
        systemctl enable sddm.service

    # GDM #
        #pacman -S gdm                  --noconfirm # Gnome Display Manager;
        #systemctl enable gdm.service

## Desktop Environment ##

    # Plasma KDE #
        pacman -S plasma-meta       --noconfirm # KDE Plasma Desktop Environment;
        pacman -S plasma-desktop    --noconfirm # Utilities for Plasma Desktop;
        pacman -S konsole           --noconfirm # Konsole Terminal;

    # Gnome #
        #pacman -S gnome                    --noconfirm # Gnome Desktop Environment;
        #pacman -S gnome-terminal           --noconfirm # Gnome Terminal;

## Create User ##

    # User Creation #
        SET_USER="gnsbriellh"
        useradd -m -G wheel -s /bin/bash $SET_USER

        echo "Set password for $SET_USER"
        passwd gnsbriellh

        echo "Set password for root user"
        passwd root

    # Adding User to Sudoers #
        sleep 2 ; echo "Visudo will now open in 3s..." ; sleep 3
        EDITOR=nano visudo

## Done... ##

    # Finished #
        echo "Installation Has been Completed !"

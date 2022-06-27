#!/bin/bash

##
## Arch Linux install ¨Script¨
##
## Refer to ¨https://wiki.archlinux.org/title/installation_guide¨
## For a complete Installation Guide.
##
## The commands bellow are just for some common used commands
## in any installation of arch linux.
##

## Pre-Boot ##

    timedatectl set-ntp true    # To ensure the system clock is accurate
    timedatectl status  # To check the service status

    ## Partitioning ##

        fdisk -l    # To list all available drivers
        fdisk /dev/nvme0n1  # To Partition a specific driver

            # p1= +266290M  | Linux filesystem
            # p2= +807M     | EFI System
            # p3= +16434M   | Linux Swap
            # p4= [ENTER]   | Linux filesystem

        mkfs.ext4 /dev/nvme0n1p1    # Format root driver to ext4
        mkfs.fat -F32 /dev/nvme0n1p2    # Format boot driver to fat32
        mkswap /dev/nvme0n1p3   # Format swap driver to linux-swap
        mkfs.ext4 /dev/nvme0n1p4    # Format home driver to ext4

        mount /dev/nvme0n1p1 /mnt
        mkdir /mnt/boot/efi -p
        mkdir /mnt/home

        mount /dev/nvme0n1p2 /mnt/boot/efi
        swapon /dev/nvme0n1p3
        mount /dev/nvme0n1p4 /mnt/home

    ## Install Essential Packages ##

        pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd # Install essential packages

    ## Configuring the system ##

        genfstab -U /mnt >> /mnt/etc/fstab                          # Gerenerates the FSTAB file

        arch-chroot /mnt                                            # Chroot to /mnt

        ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime # Set Time Zone
        hwclock --systohc                                           # Generate /etc/adjtime

        nano /etc/locale.gen                                        # Uncomment ¨en_US.UTF-8 UTF-8¨
        locale-gen                                                  # Generate the locales
        echo LANG=en_US.UTF-8 >> /etc/locale.conf                   # Set LANG variable
        pt_BR.UTF-8

        echo *HOSTNAME* >> /etc/hostname                            # Set the Hostname

        nano /etc/machine-info                                      # set the Pretty Hostname
            ## PRETTY_HOSTNAME="PRETTY HOSTNAME"
            ## ICON_NAME=computer
            ## CHASSIS=desktop
            ## DEPLOYMENT=production

        nano /etc/hosts                                             # Configure localhosts
            ## 127.0.0.1    localhost
            ## ::1          localhost
            ## 127.0.1.1    *HOSTNAME*

    ## Uncomment multilib to increase package providers ##

        nano /etc/pacman.conf
        ## [multilib]
        ## Include = /etc/pacman.d/mirrorlist
        pacman -Sy

    ## Installing Other Packages ##

        pacman -S man-db
        pacman -S man-pages
        pacman -S dosfstools
        pacman -S os-prober
        pacman -S mtools
        pacman -S networkmanager
        pacman -S network-manager-applet
        pacman -S wpa_supplicant
        pacman -S wireless_tools
        pacman -S dialog
        pacman -S grub
        pacman -S efibootmgr
        pacman -S intel-ucode

        systemctl enable NetworkManager.service # permanently enable network

    ## Config Boot Loader ##

        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck # Complete installation of Grub and Microcode

        nano /etc/default/grub
            # GRUB_TIMEOUT=*0.1*
        grub-mkconfig -o /boot/grub/grub.cfg    # generate grub.cfg

    ## Create a new user and add to sudoers ##

        useradd -m -G wheel -s /bin/bash *user*   # Create User
        passwd *user*   # Change User password

        EDITOR=nano visudo # Uncomment the wheel group to add user to sudoers

    ## Reboot ##

        exit
        umount -R /mnt
        reboot now

    ## Install GPU Drivers ##

        sudo pacman -S xorg
        sudo pacman -S mesa
        sudo pacman -S lib32-mesa
        sudo pacman -S xf86-video-amdgpu
        sudo pacman -S vulkan-radeon
        sudo pacman -S lib32-vulkan-radeon
        sudo pacman -S libva-mesa-driver
        sudo pacman -S lib32-libva-mesa-driver
        sudo pacman -S mesa-vdpau
        sudo pacman -S lib32-mesa-vdpau

    ## Install a Desktop Environment ##

        sudo pacman -S gdm

        sudo pacman -S gnome
        sudo pacman -S gnome-tweaks
        sudo pacman -S gnome-shell-extensions
        sudo pacman -S gnome-shell-extension-appindicator
        sudo pacman -S webp-pixbuf-loader
        #sudo pacman -S chrome-gnome-shell (AUR)
        #sudo pacman -S gnome-extra

        sudo systemctl start gdm.service
        sudo systemctl enable gdm.service


## Post Install ##

        sudo pacman -S lib32-fontconfig ttf-liberation wqy-zenhei ## fix steam fonts
        sudo pacman -S noto-fonts-emoji # Fix Emoji Selector showing blank Squares.
        sudo pacman -S ufw # Installs a Firewall
        sudo systemctl enable ufw.service

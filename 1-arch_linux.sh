#!/bin/bash

        ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime -v

        hwclock --systohc -v

        sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
        
        locale-gen
        
        echo LANG=en_US.UTF-8 >> /etc/locale.conf

        echo gnsbriellh-desktop >> /etc/hostname

        PRETTY_HOSTNAME="Gabriel's Desktop"
        ICON_NAME="computer"
        CHASSIS="desktop"
        DEPLOYMENT="production"

        echo PRETTY_HOSTNAME="'"$PRETTY_HOSTNAME"'" >> /etc/machine-info
        echo ICON_NAME=$ICON_NAME                   >> /etc/machine-info
        echo CHASSIS=$CHASSIS                       >> /etc/machine-info
        echo DEPLOYMENT=$DEPLOYMENT                 >> /etc/machine-info

        echo "127.0.0.1    localhost"                                           >> /etc/hosts
        echo "::1          localhost"                                           >> /etc/hosts
        echo "127.0.1.1    gnsbriellh-desktop.localdomain gnsbriellh-desktop"   >> /etc/hosts

        echo "[multilib]"                           >> /etc/pacman.conf
        echo "Include = /etc/pacman.d/mirrorlist"   >> /etc/pacman.conf

        pacman -Sy                          --noconfirm
        pacman -S man-db                    --noconfirm
        pacman -S man-pages                 --noconfirm
        pacman -S dosfstools                --noconfirm
        pacman -S os-prober                 --noconfirm
        pacman -S mtools                    --noconfirm
        pacman -S networkmanager            --noconfirm
        pacman -S network-manager-applet    --noconfirm
        pacman -S wpa_supplicant            --noconfirm
        pacman -S wireless_tools            --noconfirm
        pacman -S dialog                    --noconfirm
        pacman -S grub                      --noconfirm
        pacman -S efibootmgr                --noconfirm
        pacman -S intel-ucode               --noconfirm

        grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck

        sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0.1/g' /etc/default/grub
            
        grub-mkconfig -o /boot/grub/grub.cfg

        pacman -S xorg                      --noconfirm
        pacman -S mesa                      --noconfirm
        pacman -S lib32-mesa                --noconfirm
        pacman -S xf86-video-amdgpu         --noconfirm
        pacman -S vulkan-radeon             --noconfirm
        pacman -S lib32-vulkan-radeon       --noconfirm
        pacman -S libva-mesa-driver         --noconfirm
        pacman -S lib32-libva-mesa-driver   --noconfirm
        pacman -S mesa-vdpau                --noconfirm
        pacman -S lib32-mesa-vdpau          --noconfirm

        pacman -S sddm                      --noconfirm

        pacman -S plasma                    --noconfirm
        pacman -S plasma-desktop            --noconfirm
        pacman -S plasma-wayland-session    --noconfirm
        pacman -S kde-applications          --noconfirm
        pacman -S kdegraphics-thumbnailers  --noconfirm
        pacman -S noto-fonts-emoji          --noconfirm
        pacman -S ffmpegthumbs              --noconfirm
        pacman -S kde-gtk-config            --noconfirm
        pacman -S packagekit-qt5            --noconfirm
        pacman -S alsa-utils                --noconfirm
        pacman -S ufw                       --noconfirm

        systemctl enable sddm.service
        systemctl enable NetworkManager.service
        systemctl enable ufw.service

        SET_USER="gnsbriellh"

        useradd -m -G wheel -s /bin/bash $SET_USER

        echo "Set password for $SET_USER"
        passwd gnsbriellh
        echo "Set password for root user"
        passwd root

        EDITOR=nano visudo

        echo "Installation Completed !"


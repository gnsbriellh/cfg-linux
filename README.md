<h1>Installation Guide (Arch Linux)</h1>
<p>Refer to the <a href="https://wiki.archlinux.org/title/Installation_guide">Offical Installation Guide<a></p>
<h3>Installing Raw Arch</h3>
<p>1 - (Optional) Configure System Clock and Keyboard Layout</p>

    timedatectl set-ntp true
    loadkeys us-acentos

<p>2 - Partitioning</p>

    fdisk -l            | To list all available drivers
    
    fdisk /dev/nvme0n1  | To Partition a specific driver
        # p1= +266290M  | Linux filesystem
        # p2= +807M     | EFI System
        # p3= +16434M   | Linux Swap
        # p4= [ENTER]   | Linux filesystem

<p>3 - Formating</p>

    mkfs.ext4 /dev/nvme0n1p1        | Format root driver to ext4
    mkfs.fat -F32 /dev/nvme0n1p2    | Format boot driver to fat32
    mkswap /dev/nvme0n1p3           | Format swap driver to linux-swap
    mkfs.ext4 /dev/nvme0n1p4        | Format home driver to ext4

<p>4 - Mounting</p>

    mount /dev/nvme0n1p1 /mnt
    mkdir /mnt/boot/efi -p
    mkdir /mnt/home

    mount /dev/nvme0n1p2 /mnt/boot/efi
    swapon /dev/nvme0n1p3
    mount /dev/nvme0n1p4 /mnt/home

<p>5 - Pacstrap</p>

    pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd

<p>6 - Configuring the System</p>

    #Generate /etc/fstab
    genfstab -U /mnt >> /mnt/etc/fstab

    #chroot into the system
    arch-chroot /mnt # Chroot to /mnt

    #set time zone
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

    #genereate /etc/adjtime
    hwclock --systohc # Generate

    # Uncomment "en_US.UTF-8 UTF-8"
    nano /etc/locale.gen 

    # Generate the locales
    locale-gen 

    # Set LANG variable
    echo LANG=en_US.UTF-8 >> /etc/locale.conf 

    # Set the Hostname
    echo *HOSTNAME* >> /etc/hostname 

    # Add into:
    nano /etc/machine-info 
        ## PRETTY_HOSTNAME="PRETTY HOSTNAME"
        ## ICON_NAME=computer
        ## CHASSIS=desktop
        ## DEPLOYMENT=production
        
    # Add into:
    nano /etc/hosts
        ## 127.0.0.1    localhost
        ## ::1          localhost
        ## 127.0.1.1    *HOSTNAME*.localdomain *HOSTNAME*

    # Add into:
    nano /etc/vconsole.conf
        ## KEYMAP=us-acentos

    # Uncomment multilib to increase package providers
    nano /etc/pacman.conf
        ## [multilib]
        ## Include = /etc/pacman.d/mirrorlist

<p>7 - Installing Other Packages</p>

    pacman -Sy
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

<p>8 - Configure Boot Loader</p>

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck

    # Change:
    nano /etc/default/grub
        # GRUB_TIMEOUT=*0.1*
    
    # Generate grub.cfg
    grub-mkconfig -o /boot/grub/grub.cfg

<p>9 - Install GPU Drivers</p>

    pacman -S xorg
    pacman -S mesa
    pacman -S lib32-mesa
    pacman -S xf86-video-amdgpu
    pacman -S vulkan-radeon
    pacman -S lib32-vulkan-radeon
    pacman -S libva-mesa-driver
    pacman -S lib32-libva-mesa-driver
    pacman -S mesa-vdpau
    pacman -S lib32-mesa-vdpau

<p>10 - Create a new user and add to sudoers</p>

    useradd -m -G wheel -s /bin/zsh *user*
    passwd *user*   # Change User password

    EDITOR=nano visudo # Uncomment the wheel group to add user to sudoers
    
    #change root's password
    passwd root

    reboot
    
<p>11 - Install a DE</p>

    pacman -S sddm
    pacman -S plasma
    pacman -S plasma-desktop
    pacman -S plasma-wayland-session
    pacman -S kde-applications
    pacman -S kdegraphics-thumbnailers
    pacman -S ffmpegthumbs
    pacman -S kde-gtk-config
    pacman -S packagekit-qt5
    pacman -S alsa-utils
    pacman -S ufw

    systemctl enable sddm.service
    systemctl enable NetworkManager.service
    systemctl enable ufw.service

    reboot

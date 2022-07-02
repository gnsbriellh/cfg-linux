<div>
    <h1>Installation Guide (Arch Linux)</h1>
        <p>Refer to the <a href="https://wiki.archlinux.org/title/Installation_guide">Offical Installation Guide<a></p>
</div>

<div>
    <h2>Installing Arch</h2>
</div>

<div>
    <h3>Optional</h3>
    <p>
        Configure System Clock and Keyboard Layout
    </p>

    timedatectl set-ntp true
    loadkeys us-acentos

</div>

<div>
    <h3>Partitioning</h3>

        fdisk -l            # List Available Drivers;
        fdisk /dev/nvme0n1  # Partition a specific driver;
            # p1= +163890M  # Root - Linux filesystem;
            # p2= +807M     # Boot - EFI System;
            # p3= +16434M   # Swap - Linux Swap;
            # p4= [ENTER]   # Home - Linux filesystem;

</div>

<div>
    <h3>Formating</h3>

        mkfs.ext4 /dev/nvme0n1p1        # Format root driver to ext4;
        mkfs.fat -F32 /dev/nvme0n1p2    # Format boot driver to fat32;
        mkswap /dev/nvme0n1p3           # Format swap driver to linux-swap;
        mkfs.ext4 /dev/nvme0n1p4        # Format home driver to ext4;

</div>

<div>
    <h3>Mounting</h3>

        mount /dev/nvme0n1p1 /mnt

        mkdir /mnt/boot/efi -p
        mkdir /mnt/home

        mount /dev/nvme0n1p2 /mnt/boot/efi
        swapon /dev/nvme0n1p3
        mount /dev/nvme0n1p4 /mnt/home

</div>

<div>
    <h3>Pacstrap</h3>

        pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd

</div>

<div>
<h3>Configuring the System</h3>
<p><a href="https://github.com/gnsbriellh/cfg-linux/blob/main/1-Install_LiveDisk.sh">Either use the file "1-Install_LiveDisk.sh" for an automated install of KDE, or follow the steps below.<a></p>
<h5>Generate fstab File</h5>
    
    genfstab -U /mnt >> /mnt/etc/fstab

<h5>chroot into the system</h5>

    arch-chroot /mnt # Chroot to /mnt

<h5>set time zone</h5>

    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

<h5>genereate /etc/adjtime</h5>

    hwclock --systohc # Generate

<h5>Uncomment "en_US.UTF-8 UTF-8"</h5>

    sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen 

<h5>Generate the locales</h5>

    locale-gen 

<h5>Set LANG variable</h5>

    echo LANG=en_US.UTF-8 >> /etc/locale.conf 

<h5>Set the Hostname</h5>

    echo *HOSTNAME* >> /etc/hostname 

<h5>Set the Pretty Hostname</h5>

    echo "PRETTY_HOSTNAME='*PRETTY HOSTNAME*'" >> /etc/machine-info
    echo "ICON_NAME=computer" >> /etc/machine-info
    echo "CHASSIS=desktop" >> /etc/machine-info
    echo "DEPLOYMENT=production" >> /etc/machine-info

<h5>Set hosts</h5>

    echo "127.0.0.1     localhost" >> /etc/hosts
    echo "::1           localhost" >> /etc/hosts
    echo "127.0.1.1     *HOSTNAME*.localdomain *HOSTNAME*" >> /etc/hosts

<h5>Console Keymap</h5>

    echo "KEYMAP=us-acentos" >> /etc/vconsole.conf

<h5>Increase package providers</h5>
 
    echo "[multilib]" >> /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

</div>

<div>
<h3>Installing Other Packages</h3>

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

    systemctl enable NetworkManager.service

</div>

<div>
<h3>Configure Boot Loader</h3>

<h5>Install GRUB</h5>

    Pacman -S grub          --noconfirm # Bootloader;
    pacman -S efibootmgr    --noconfirm # EFI Bootmanager;
    pacman -S intel-ucode   --noconfirm # Intel Microcode Update Utility;

    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck

<h5>Remove Grub Timer</h5>

    sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0.1/g' /etc/default/grub

<h5>Generate grub.cfg</h5>

    grub-mkconfig -o /boot/grub/grub.cfg

</div>

<div>
<h3>Install GPU Drivers</h3>

<h5>AMD</h5>

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

</div>

<div>
<h3>Create a new user and add to sudoers</h3>

    useradd -m -G wheel -s /bin/bash *USER*
    passwd *USER*

    
<h5>Change Root's Password</h5>

    passwd root

<h5>Change/Add Sudoers</h5>

    EDITOR=nano visudo

</div>

<h2>Desktop Environment</h2>

<div>
<h3>KDE Plasma</h3>

    pacman -S sddm              --noconfirm # KDE Display Manager;
    pacman -S plasma-meta       --noconfirm # KDE Plasma Desktop Environment;
    pacman -S plasma-desktop    --noconfirm # Utilities for Plasma Desktop;
    pacman -S konsole           --noconfirm # Konsole Terminal;
    systemctl enable sddm.service

<h3>GNOME</h3>

    pacman -S gdm                   --noconfirm # Gnome Display Manager;
    pacman -S gnome                 --noconfirm # Gnome Desktop Environment;
    pacman -S gnome-terminal        --noconfirm # Gnome Terminal;
    systemctl enable gdm.service

</div>

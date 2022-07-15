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

        pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd git

</div>

<div>
<h5>Generate fstab File</h5>
    
    genfstab -U /mnt >> /mnt/etc/fstab

<h5>chroot into the system</h5>

    arch-chroot /mnt # Chroot to /mnt

<h3>Configuring the System</h3>
<p>Either use the file "base-sys-configh" for an automated configuration, or follow the steps in the <a href="https://wiki.archlinux.org/title/Installation_guide">Arch Wiki</a>.<a></p>

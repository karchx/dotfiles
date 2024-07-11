#!/bin/bash
TIME_ZONE="America/Guatemala"
LANGUAGE="es_ES"
HOSTNAME="stivarch"
USERNAME="stivarch"

# Core package
corePkgs=(acpid cups dhcp git grub htop iftop neofetch networkmanager os-prober pacman-contrib sudo emacs-nox wget)

#
# System clock
#
function set_clock () {
    echo "Setting the system clock"
    timedatectl set-ntp true
    timedatectl set-timezone $TIME_ZONE
}


#
# Disk partition
#
function set_disk_partition () {
    lsblk -f
    read -p "Select your disk (eg. /dev/sda): " s_disk
    echo ""
    read -p "Are you sure is it your disk, all the data will be erased ($s_disk)? [y/N] " disk_confirmation
    if [ "$disk_confirmation" != "Y" ] && [ "$disk_confirmation" != "y" ]; then
        echo "Exiting script.."
        exit 1
    fi

    if [ "${s_disk::8}" == "/dev/nvm" ]; then
        p_disk="${s_disk}p"
    else
        p_disk="${s_disk}"
    fi

    parted ${s_disk} mklabel msdos                # BIOS (sgdisk --list-types)
    parted ${s_disk} mkpart primary 1MiB 1001MiB
    parted ${s_disk} set 1 boot on

    parted ${s_disk} mkpart primary 1001MiB 5101MiB # SWAP
    parted ${s_disk} mkpart primary 5101MiB 100%   # File System
}


#
# Set partition table
#
function set_partition_tables () {
    echo " >> Setting the partitions tables"
    mkfs.ext4 "${p_disk}1" # /boot
    mkswap "${p_disk}2" # SWAP
    mkfs.ext4 "${p_disk}3" # File System

    swapon "${p_disk}2" # On Swap
}


#
# Mount file system
#
function mount_file_system () {
    echo " >> Mounting the file system"
    mount "${p_disk}3" /mnt
    mkdir -p /mnt/boot
    mount "${p_disk}1" /mnt/boot
}


#
# Install base packages
#
function install_base_packages () {
    echo " >> Installing linux base package"
    pacstrap /mnt base base-devel linux linux-firmware linux-headers "${corePkgs}"
}

function config_system () {
    echo " >> Configuring system"
    genfstab -U /mnt >> /mnt/etc/fstab
}

#
# The end
#
function the_end () {
    echo " >> Umount /mnt"
    umount -l /mnt
    exit 0
}

set_clock

set_disk_partition

set_partition_tables

mount_file_system

install_base_packages

config_system

#sleep 2s
#clear

sed '1,/^#part2$/d' legacy-base-install.sh > /mnt/post_base-install.sh

chmod +x /mnt/post_base-install.sh
arch-chroot /mnt ./post_base-install.sh
clear

#part2

function chroot_symlink () {
    echo " >> Creating symlink for the localetime"
    ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
}
function chroot_hwclock () {
    echo " >> Setting the hardware clock"
    hwclock --systohc
}
function chroot_locale_gen () {
    echo " >> Setting the system language"
    echo "$LANGUAGE.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
}
function chroot_hosts () {
    echo " >> Setting the system hosts"
    echo $HOSTNAME > /etc/hostname
    echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts
}
function chroot_passwd () {
    echo " >> Changing root password"
	passed=1
	while [[ ${passed} != 0 ]]; do
		passwd root
		passed=$?
	done
}
function chroot_add_user () {
    echo " >> Changing $USERNAME password"
	useradd -m $USERNAME
    passed=1
	while [[ ${passed} != 0 ]]; do
		passwd $USERNAME
		passed=$?
	done
}
function chroot_add_user_groups () {
    echo " >> Adding groups to $USERNAME"
    usermod -aG wheel,audio,video,optical,storage $USERNAME
}
function chroot_config_sudo () {
    echo " >> Configuring visudo"
    pacman -S --needed --noconfirm sudo
    sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL:ALL)\s\+ALL\)/\1/' /etc/sudoers
}
function chroot_install_bootloader () {
    echo " >> Installing the bootloader"
    pacman -S --needed --noconfirm grub-bios
}
function chroot_grub_config () {
    echo " >> Configuring the grub ${p_disk}"
    grub-install --target=i386-pc "${p_disk}"
    grub-mkconfig -o /boot/grub/grub.cfg
}
function chroot_network_manager () {
    echo " >> Installing the network manager"
    pacman -S --needed --noconfirm networkmanager git
    systemctl enable NetworkManager
}

chroot_symlink

chroot_hwclock

chroot_locale_gen

chroot_hosts

chroot_passwd

chroot_add_user

chroot_add_user_groups

chroot_config_sudo

clear

chroot_install_bootloader

chroot_grub_config

chroot_network_manager

the_end

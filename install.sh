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


#
# System configuration
#
function config_system () {
    echo " >> Configuring system"
    genfstab -U /mnt >> /mnt/etc/fstab
    arch_chroot "_chroot_symlink"
    arch_chroot "_chroot_hwclock"
    arch_chroot "_chroot_locale_gen"
    arch_chroot "_chroot_hosts"
    arch_chroot "_chroot_passwd"
    arch_chroot "_chroot_add_user"
    arch_chroot "_chroot_add_user_groups"
    arch_chroot "_chroot_config_sudo"
}
function chroot_symlink () {
    echo " >> Creating symlink for the localetime"
    ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
    exit 0
}
function chroot_hwclock () {
    echo " >> Setting the hardware clock"
    hwclock --systohc
    exit 0
}
function chroot_locale_gen () {
    echo " >> Setting the system language"
    echo "$LANGUAGE.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    exit 0
}
function chroot_hosts () {
    echo " >> Setting the system hosts"
    echo $HOSTNAME > /etc/hostname
    echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts
    exit 0
}
function chroot_passwd () {
    echo " >> Changing root password"
	passed=1
	while [[ ${passed} != 0 ]]; do
		passwd root
		passed=$?
	done
    exit 0
}
function chroot_add_user () {
    echo " >> Changing $USERNAME password"
	useradd -m $USERNAME
    passed=1
	while [[ ${passed} != 0 ]]; do
		passwd $USERNAME
		passed=$?
	done
    exit 0
}
function chroot_add_user_groups () {
    echo " >> Adding groups to $USERNAME"
    usermod -aG wheel,audio,video,optical,storage $USERNAME
    exit 0
}
function chroot_config_sudo () {
    echo " >> Configuring visudo"
    pacman -S --needed --noconfirm sudo
    sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL:ALL)\s\+ALL\)/\1/' /etc/sudoers
    exit 0
}


#
# Config bootloader
#
function config_bootloader () {
    arch_chroot "_chroot_install_bootloader"
    arch_chroot "_chroot_grub_config"
}
function chroot_install_bootloader () {
    echo " >> Installing the bootloader"
    pacman -S --needed --noconfirm grub-bios
    exit 0
}
function chroot_grub_config () {
    echo " >> Configuring the grub ${p_disk}"
    grub-install --target=i386-pc "${p_disk}"
    grub-mkconfig -o /boot/grub/grub.cfg
    exit 0
}


#
# Config network manager
#
function config_network_manager () {
    arch_chroot "_chroot_network_manager"
}
function chroot_network_manager () {
    echo " >> Installing the network manager"
    pacman -S --needed --noconfirm networkmanager git
    systemctl enable NetworkManager
    exit 0
}


#
# The end
#
function the_end () {
    echo " >> Umount /mnt"
    umount -l /mnt
    exit 0
}


#
# Arch chroot
#
function arch_chroot () {
	echo " >> arch-chroot /mnt /root"
	cp ${0} /mnt/root
	chmod 755 /mnt/root/$(basename "${0}")
	arch-chroot /mnt /root/$(basename "${0}") --chroot ${1} ${2}
	rm /mnt/root/$(basename "${0}")
	echo " >> exit arch-chroot"
}


#
# Main
#
function main () {
    if [[ $1 == "--chroot" ]]; then
        case ${2} in
            '_chroot_symlink') chroot_symlink;;
            '_chroot_hwclock') chroot_hwclock;;
            '_chroot_locale_gen') chroot_locale_gen;;
            '_chroot_hosts') chroot_hosts;;
            '_chroot_passwd') chroot_passwd;;
            '_chroot_add_user') chroot_add_user;;
            '_chroot_add_user_groups') chroot_add_user_groups;;
            '_chroot_config_doas') chroot_config_doas;;
            '_chroot_config_sudo') chroot_config_sudo;;
            '_chroot_install_bootloader') chroot_install_bootloader;;
            '_chroot_grub_config') chroot_grub_config;;
            '_chroot_network_manager') chroot_network_manager;;
        esac
    else

        set_clock

        set_disk_partition

        set_partition_tables

        mount_file_system

        install_base_packages

        config_system

        config_bootloader

        config_network_manager

        the_end

    fi
}


main "$@"

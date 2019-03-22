#!/bin/bash

#pre-reboot.sh hostname  

####################
#Basic Configuration
####################
echo $1 > /etc/hostname
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen 
locale-gen
localectl set-locale LANG=en_US.UTF-8
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
useradd -m -g users -G wheel,power,storage,audio -s /bin/bash trevor
echo 'Setting ROOT passwd...'
passwd
echo 'Setting USER password...'
passwd trevor
pacman -S vim
visudo

#Install Bootloader
echo 'Installing GRUB...'
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

################################
#Pre-Reboot Package Installation
################################

echo 'Installing basic utilities...'
pacman -S networkmanager acpi tlp powertop htop light jsoncpp
systemctl enable tlp.service tlp-sleep.service NetworkManager.service

echo 'Installing graphics/display...'
pacman -S xf86-video-intel

echo 'Installing audio...'
pacman -S alsa-utils pulseaudio mpd

echo 'Installing window manager...'
pacman -S xorg xorg-xinit xautolock i3 compton nitrogen dmenu rofi xfce4-panel

echo 'Installing core apps...'
pacman -S rxvt-unicode pcmanfm ranger firefox lxappearance arandr xarchiver gpicview

echo 'Installing theme...' 
pacman -S arc-gtk-theme papirus-icon-theme ttf-font-awesome ttf-ubuntu-font-family

echo 'Copying post-reboot.sh to /home/trevor'
cp post-x220.sh /home/trevor
chown trevor /home/trevor/post-reboot.sh

echo 'Done!'



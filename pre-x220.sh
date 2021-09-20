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
pacman -S vim xf86-video-intel networkmanager alsa-utils pulseaudio tlp powertop htop
systemctl enable tlp.service tlp-sleep.service NetworkManager.service

echo 'Done!'



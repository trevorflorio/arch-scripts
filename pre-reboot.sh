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
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

################################
#Pre-Reboot Package Installation
################################

echo 'Installing basic utilities...'
pacman -S networkmanager acpi tlp powertop htop light
systemctl enable tlp.service tlp-sleep.service

echo 'Installing graphics/display...'
pacman -S xf86-video-intel nvidia bumblebee bbswitch
gpasswd -a trevor bumblebee
systemctl enable bumblebeed.service

echo 'Installing audio...'
pacman -S alsa-utils pulseaudio jack mpd

echo 'Installing window manager...'
pacman -S xorg xorg-xinit xautolock i3 compton nitrogen dmenu rofi

echo 'Installing core apps...'
pacman -S rxvt-unicode tilda pcmanfm ranger firefox lxappearance arandr xarchiver gpicview

echo 'Installing theme...' 
pacman -S adapta-gtk-theme papirus-icon-theme ttf-font-awesome ttf-ubuntu-font-family terminus-font

echo 'Copying post-reboot.sh to /home/trevor'
cp post-reboot.sh /home/trevor
chown trevor /home/trevor/post-reboot.sh

echo 'Done!'



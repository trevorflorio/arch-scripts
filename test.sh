#!/bin/sh

#make sure dat mothafucka is root
if [ $EUID -ne 0 ]; then
 echo "RUN DAT SHIT AS ROOT, BITCH..." > /dev/stderr
 exit 1
fi

#basic xorg/video setup
pacman -Sy xorg-server xorg-server-utils xorg-xinit xterm mesa xf86-video-intel 


pacman -S cinnamon gdm
systemcrl enable gdm.service

pacman -S tlp powertop htop
systemctl enable tlp.service
systemctl enable tlp-sleep.service
tlp start

#INSTALL GNOME STUFF
pacman -S gnome-terminal gnome-calculator eog evince epiphany gnome-disk-utility gnome-system-monitor file-roller gedit gnome-screenshot cheese transmission-gtk vlc

#GET AND INSTALL PACAUR
git clone https://aur.archlinux.org/pacaur.git
cd pacaur 
makepkg -sri
cd ..
rm -rf pacaur

pacaur -S vertex-themes numix-circle-icon-theme-git chromium firefox opera vivaldi libreoffice-fresh





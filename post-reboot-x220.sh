#!/bin/bash

ehco 'Installing AUR helper'
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sri
cd ..
rm -rf yay

echo 'Installing Core AUR packages...'
yay -S twmn-git polybar

echo 'Setting up config files...'
cd ..
git clone https://github.com/trevorflorio/dotfiles
cd dotfiles

mkdir ~/.config/i3
ln -f .i3config ~/.config/i3/config

mkdir ~/.config/rofi
ln -f .roficonfig ~/.config/rofi/config

ln -f .Xdefaults ~/.Xdefaults
ln -f .bashrc ~/.bashrc

cp -r polybar ~/.config
mkdir ~/.fonts
cp polybar/fonts/* ~/.fonts

cd ..
touch .xinitrc
echo 'exec i3' > .xinitrc

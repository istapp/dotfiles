#!/bin/bash
## BASE PACKAGE INSTALL SCRIPT
# Make sure our shiny new arch is up-to-date
echo "Checking for system updates..."
sudo pacman -Syu

# Create a tmp-working-dir and navigate into it
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

# If you didn't install the "base-devel" group,
# we'll need those.
sudo pacman -S binutils make gcc fakeroot pkg-config --noconfirm --needed

# Install pacaur dependencies from arch repos
sudo pacman -S expac yajl git --noconfirm --needed

# Install "cower" from AUR
if [ ! -n "$(pacman -Qs cower)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
    makepkg PKGBUILD --skippgpcheck --install --needed
fi

# Install "pacaur" from AUR
if [ ! -n "$(pacman -Qs pacaur)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
    makepkg PKGBUILD --install --needed
fi

# Clean up...
cd ~
rm -r /tmp/pacaur_install

echo "Installing progs"
# Window Manager
sudo pacman -S xorg-server xorg-xinit xorg-xrdb xorg compton xdg-user-dirs xautolock dialog awesome gtk-engine-murrine lxappearance-gtk3 adapta-gtk-theme imagemagick --noconfirm --needed

# Terminal
sudo pacman -S fzf neofetch neovim zsh tmux --noconfirm --needed

# File Manager
sudo pacman -S ranger atool w3m dosfstools exfat-utils feh libaca mediainfo highlight zathura zatura-pdf-mupdf zathura-djvu unzip unrar poppler ntfs-3g python-pillow python2-pillow file  --noconfirm --needed

# Browser
sudo pacman -S qutebrowser --noconfirm --needed

# Media
sudo pacman -S mpd youtube-dl youtube-viewer mpv mpc ncmpcpp alsa-utils --noconfirm --needed

# Email
sudo pacman -S thunderbird --noconfirm --needed

# Battery
sudo pacman -S acpi tlp acpid powertop --noconfirm --needed

# TeX
sudo pacman -S biber texlive-lang texlive-most --noconfirm --needed

# Network
sudo pacman -S wpa_actiond wpa_supplicant iw chrony --noconfirm --needed

# Font
sudo pacman -S freetype2 freetype2-docs ttf-hack  --noconfirm --needed

# Pandoc
sudo pacman -S r pandoc pandoc-citeproc --noconfirm --needed

# Misc
sudo pacman -S gvim ctags fzf cups libreoffice-fresh gimp maim reflector udisks2 pacman-contrib --noconfirm --needed


pacaur -S i3lock-color-git light-git words-insane nvme-cli --noedit --noconfirm

##Repo
cd $HOME
git clone https://github.com/istapp/st.git
cd st
make
sudo make clean install
cd $HOME

## Make dirs
mkdir -p $HOME/desktop
mkdir -p $HOME/documents
mkdir -p $HOME/downloads
mkdir -p $HOME/music
mkdir -p $HOME/pictures
mkdir -p $HOME/public
mkdir -p $HOME/templates
mkdir -p $HOME/videos

sudo cp -fs $HOME/.config/awesome/themes/gruvbox/wallpapers/wall.png $HOME/pictures/wall.png
sudo cp -fs $HOME/.config/awesome/themes/gruvbox/wallpapers/lock.png $HOME/pictures/lock.png





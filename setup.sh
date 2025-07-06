#-----Yay-----#
#!/bin/bash

# Function to install yay
install_yay() {
    echo "Installing Yay..."
    sleep 3
    sudo pacman -S --needed git base-devel --noconfirm || { echo "Failed to install dependencies"; exit 1; }
    git clone https://aur.archlinux.org/yay.git /tmp/yay || { echo "Failed to clone yay"; exit 1; }
    cd /tmp/yay || exit 1
    makepkg -si --noconfirm || { echo "Failed to build/install yay"; exit 1; }
    cd ..
    rm -rf /tmp/yay
    echo "yay installed successfully!"
}

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay is not installed."
    install_yay
else
    echo "yay is already installed (version: $(yay --version | head -n 1))."
fi


#-----AUR-----#

echo "Installing AUR Packages"
sleep 3

yay -S --needed --noconfirm \
	hyprpaper \
	hyprshot \
	hyprpicker \
	wl-clipboard \
	firefox \
	nemo \
	nwg-look \
	python-pywal16 \
	python-pywalfox \
	zsh \
	otf-hermit-nerd \
	ttf-font-awesome \
	ttf-font-awesome-4 \
	ttf-font-awesome-5 \
	waybar \
	rust \
	cargo \
	fastfetch \
	cmatrix \
	pavucontrol \
	arch-gaming-meta \
	dxvk-bin \
	waybar-module-pacman-updates-git \
	python-pip \
	python-virtualenv \
	xfce4-settings \
	rofi-wayland \


#-----Oh-My-Zsh-----#



echo "Installing Oh-My-Zsh"
sleep 3

mkdir -p /home/$USER/dots/omz


git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "/home/$USER/dots/omz/zsh-autosuggestions/"
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "/home/$USER/dots/omz/zsh-syntax-highlighting/"
git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" "/home/$USER/dots/omz/fast-syntax-highlighting/"
git clone --depth 1 -- "https://github.com/marlonrichert/zsh-autocomplete.git" "/home/$USER/dots/omz/zsh-autocomplete/"
git clone "https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git" "/home/$USER/dots/omz/autoswitch_virtualenv/"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -rf ~/.zshrc

cp -r /home/$USER/dots/omz/autoswitch_virtualenv/ ~/.oh-my-zsh/custom/plugins/
cp -r /home/$USER/dots/omz/fast-syntax-highlighting/ ~/.oh-my-zsh/custom/plugins/
cp -r /home/$USER/dots/omz/zsh-autocomplete/ ~/.oh-my-zsh/custom/plugins/
cp -r /home/$USER/dots/omz/zsh-autosuggestions/ ~/.oh-my-zsh/custom/plugins/
cp -r /home/$USER/dots/omz/zsh-syntax-highlighting/ ~/.oh-my-zsh/custom/plugins/

#-----Config-Symlink-----#
echo "Symlinking Configs"
sleep 3

ln -s /home/$USER/dots/.zshrc /home/$USER/
rm -rf /home/$USER/dots/omz/

rm -rf /home/$USER/.config/hypr
rm -rf /home/$USER/.config/kitty

ln -s /home/$USER/dots/fastfetch/ /home/$USER/.config/
ln -s /home/$USER/dots/gtk-3.0/ /home/$USER/.config/
ln -s /home/$USER/dots/gtk-4.0/ /home/$USER/.config/
ln -s /home/$USER/dots/hypr/ /home/$USER/.config/
ln -s /home/$USER/dots/kitty/ /home/$USER/.config/
ln -s /home/$USER/dots/oomox-qtstyleplugin/ /home/$USER/.config/
ln -s /home/$USER/dots/qt5ct/ /home/$USER/.config/
ln -s /home/$USER/dots/qt6ct/ /home/$USER/.config/
ln -s /home/$USER/dots/rofi/ /home/$USER/.config/
ln -s /home/$USER/dots/scripts/ /home/$USER/.config/
ln -s /home/$USER/dots/walls/ /home/$USER/.config/
ln -s /home/$USER/dots/waybar/ /home/$USER/.config/
ln -s /home/$USER/dots/.icons/ /home/$USER/
ln -s /home/$USER/dots/.themes/ /home/$USER/
ln -s /home/$USER/dots/.vim/ /home/$USER/

echo "Symlinking Sys Configs"
sleep 3
sudo rm -rf /usr/share/icons/default
sudo cp -r /home/$USER/dots/sys/default /usr/share/icons/
sudo cp -r /home/$USER/dots/sys/Future-dark-cursors /usr/share/icons/

sudo mkdir -p /usr/share/backgrounds/
sudo cp -r /home/$USER/dots/walls/active.jpg /usr/share/backgrounds/
sudo cp -r /home/$USER/dots/.icons/oomox-everforest /usr/share/icons/
sudo cp -r /home/$USER/dots/.themes/oomox-everforest /usr/share/themes/


echo "Applying Theme"
Sleep 3

gsettings set org.gnome.desktop.interface cursor-theme "Future-dark-cursors"
gsettings set org.gnome.desktop.interface icon-theme "oomox-everforest"
gsettings set org.gnome.desktop.interface gtk-theme "oomox-everforest"
gsettings set org.gnome.desktop.interface font-name "Hurmit Nerd Font Regular 11"
gsettings set org.gnome.desktop.interface document-font-name "Hurmit Nerd Font Regular 11"
gsettings set org.gnome.desktop.interface monospace-font-name "Hurmit Nerd Font Mono Regular 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Hurmit Nerd Font Regular 11"

sudo cp -r /home/$USER/dots/sys/lightdm/ /etc/

wal -i ~/.config/walls/active.jpg  

echo "Installation Complete !!!"
echo "Rebooting The System"

sleep 3
sudo systemctl reboot

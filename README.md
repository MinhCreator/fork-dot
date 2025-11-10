# my configs for linux(for both hyprland and bspwm)
![hyprland](https://github.com/user-attachments/assets/96d1847b-ac0c-4ab1-8e2d-2729533ff4e6)

### !NOTE! this configs are made for me personally, so i don't recommend you to install all things that i have
# 1. installation
```
git clone https://github.com/deridray/dotfiles.git
cd dotfiles
chmod +x ./install.sh
./install.sh
```
# 2. manual installation
### packages:
```
# required dependencies
paru -Syu --needed --noconfirm matugen-bin firefox alacritty thunar bspwm sxhkd hyprland hyprpaper hyprcursor hyprlock hypridle rofi polybar waybar quickshell dunst mission-center swaync neofetch vim neovim nano gamemode wine wine-mono portproton xarchiver openssh gvfs flatpak pamac mpv qimgv better-control pavucontrol base-devel git networkmanager btrfs-progs udiskie flameshot htop mc playerctl zsh fish arandr nwg-look nwg-displays nwg-clipman nitrogen bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader kripton-theme-git tokyonight-gtk-theme-git ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd nerd-fonts papirus-icon-theme papirus-folders bibata-cursor-theme-bin ttf-rubik-vf ttf-material-symbols-variable-git python-materialyoucolor cmake ninja libqalculate aubio libcava ttf-roboto inter-font evolution-data-server cliphist wl-clipboard
```
```
# optional dependencies
paru -Syu --needed --noconfirm ente-auth visual-studio-code-bin steam prismlauncher discord ayugram-desktop-bin telegram-desktop spotify spicetify-cli jdk8-openjdk jdk17-openjdk jdk21-openjdk cava peaclock obs-studio gpu-screen-recorder gpu-screen-recorder-ui
```
install vencord:
```
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
```
### osu!
```
# installation
git clone https://github.com/NelloKudo/osu-winello.git
cd osu-winello
chmod +x ./osu-winello.sh
./osu-winello.sh
```
![osu! optimization link](https://github.com/NelloKudo/osu-winello/wiki/Optimizing:-osu!-performance#window-managers)
### .xinitrc
```
#!/bin/sh

# set cursor theme
xsetroot -cursor_name left_ptr
export XCURSOR_THEME="Bibata-Modern-Ice"
export XCURSOR_SIZE=24

# load Xresources
xrdb -merge ~/.Xresources

# disable screen blanking and DPMS
xset s off
xset -dpms
xset s noblank

# keyboard layouts
setxkbmap -layout us,ua,ru -option 'grp:alt_shift_toggle' &

# monitor refresh rate
xrandr --output DP-2 --mode 1920x1080 --rate 144 &

# sxhkd and bspwm
sxhkd &
exec bspwm
```
### make fish your default shell
```
chsh -s /usr/bin/fish
sudo chsh -s /usr/bin/fish root
```
or
### make zsh your default shell
```
chsh -s $(which zsh)
sudo chsh -s /usr/bin/zsh root
```
then, add plugins
```
cd $ZSH/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting
```

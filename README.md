# my configs for hyprland
<img width="1921" height="1081" alt="hyprland" src="https://github.com/user-attachments/assets/95ab5039-3544-47b0-850c-bd97b0027b65" />

## [video showcase](https://youtu.be/IKBmkHcGWys)



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
paru -Syu --needed --noconfirm stow librewolf alacritty kitty thunar yazi-git sddm hyprland hyprpaper hyprcursor hyprlock hypridle hyprpicker rofi waybar matugen-bin mission-center swaync fastfetch nano xarchiver openssh gvfs gvfs-dnssd flatpak pamac mpv qimgv better-control pavucontrol base-devel git networkmanager btrfs-progs udiskie htop playerctl fish arandr nwg-look nwg-displays nwg-clipman bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge tokyonight-gtk-theme-git ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd nerd-fonts papirus-icon-theme papirus-folders bibata-cursor-theme-bin ttf-rubik-vf ttf-material-symbols-variable-git python-materialyoucolor cmake ninja libqalculate aubio libcava ttf-roboto inter-font evolution-data-server cliphist wl-clipboard starship ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick
```
```
# optional dependencies
paru -Syu --needed --noconfirm ente-auth-bin visual-studio-code-bin vim neovim luarocks steam gamemode wine wine-mono portproton prismlauncher discord ayugram-desktop-bin telegram-desktop thunderbird spotify spicetify-cli jdk8-openjdk jdk17-openjdk jdk21-openjdk cava peaclock obs-studio gpu-screen-recorder gpu-screen-recorder-ui bitwarden losslesscut-bin logmein-hamachi haguichi
```
### install vencord:
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
### install hecade
```
curl -fsSL https://raw.githubusercontent.com/Aelune/Hecate/main/install.sh | bash
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
### enable gsr-ui service
```
systemctl enable --now --user gpu-screen-recorder-ui
```

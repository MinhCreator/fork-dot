# my configs for hyprland
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0e56d0be-e526-4470-85ba-6c26b5d375bf" />

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
# main pkgs
paru -Syu --needed --noconfirm stow librewolf-bin helium-browser-bin kitty thunar yazi-git neovim sddm hyprland hyprpaper hyprcursor hyprlock hypridle hyprpicker rofi waybar matugen-bin mission-center swaync fastfetch nano xarchiver ncdu openssh flatpak mpv qimgv better-control pavucontrol base-devel git udiskie htop playerctl fish arandr nwg-look nwg-displays nwg-clipman starship

# drivers
paru -Syu --needed --noconfirm bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge networkmanager btrfs-progs gvfs gvfs-dnssd cliphist wl-clipboard ffmpeg 7zip jq poppler fd ripgrep ripdrag fzf zoxide resvg imagemagick

# themes and fonts
paru -Syu --needed --noconfirm tokyonight-gtk-theme-git ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd nerd-fonts papirus-icon-theme bibata-cursor-theme-bin ttf-rubik-vf ttf-material-symbols-variable-git python-materialyoucolor cmake ninja libqalculate aubio libcava ttf-roboto inter-font evolution-data-server 
```

```
# optional dependencies
paru -Syu --needed --noconfirm ente-auth-bin visual-studio-code-bin luarocks steam gamemode wine wine-mono portproton prismlauncher discord ayugram-desktop-bin telegram-desktop thunderbird spotify spicetify-cli jdk8-openjdk jdk17-openjdk jdk21-openjdk cava peaclock obs-studio gpu-screen-recorder gpu-screen-recorder-ui bitwarden losslesscut-bin logmein-hamachi haguichi v4l2loopback-dkms
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

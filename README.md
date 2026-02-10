# my configs for hyprland
<img width="1920" height="1080" alt="hyprland-dusk" src="https://github.com/user-attachments/assets/dab2ee6a-2730-4505-b952-d22ce6fc2528" />
<img width="1920" height="1080" alt="hyprland-forest" src="https://github.com/user-attachments/assets/ff473bda-7c85-4478-8c9a-68e6583c5ef4" />




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
paru -Syu --needed stow librewolf-bin helium-browser-bin kitty thunar yazi-git neovim sddm hyprland swww hyprcursor hyprlock hypridle hyprpicker rofi waybar matugen-bin mission-center swaync fastfetch nano xarchiver ncdu openssh flatpak mpv qimgv better-control pavucontrol base-devel git cmake ninja udiskie btop playerctl fish arandr nwg-look nwg-displays nwg-clipman starship 

# drivers
paru -Syu --needed bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge networkmanager btrfs-progs gvfs gvfs-dnssd cliphist wl-clipboard ffmpeg 7zip jq poppler fd ripgrep ripdrag fzf zoxide resvg imagemagick libqalculate aubio libcava evolution-data-server

# themes and fonts
paru -Syu --needed tokyonight-gtk-theme-git adw-gtk-theme noto-fonts noto-fonts-emoji ttf-font-awesome nerd-fonts papirus-icon-theme bibata-cursor-theme-bin ttf-rubik-vf ttf-material-symbols-variable-git python-materialyoucolor ttf-roboto inter-font 
 
```

```
# optional dependencies
paru -Syu --needed --noconfirm ente-auth-bin visual-studio-code-bin luarocks steam gamemode wine wine-mono portproton prismlauncher discord ayugram-desktop-bin thunderbird spotify spicetify-cli jdk8-openjdk jdk17-openjdk jdk21-openjdk cava peaclock obs-studio gpu-screen-recorder gpu-screen-recorder-ui bitwarden losslesscut-bin logmein-hamachi haguichi v4l2loopback-dkms nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
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

### anti youtube shorts filter for ublock origin
```
https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt
```

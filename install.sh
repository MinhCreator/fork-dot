#!/bin/bash

set -e

DOTDIR="$HOME/dotfiles"
CONFIG_SRC="$DOTDIR/config"
HOME_SRC="$DOTDIR/home"

echo "checking paru installation..."

if ! command -v paru &> /dev/null
then
    echo "paru not found, installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
    echo "paru installed"
else
    echo "paru is already installed"
fi

# 1. update system and install packages
# We do this BEFORE linking because we need 'stow' installed
echo "starting to install packages, hold tight..."

echo "installing main dependencies..."
paru -Syu --needed stow librewolf-bin helium-browser-bin kitty thunar yazi-git neovim sddm hyprland swww hyprcursor hyprlock hypridle hyprpicker rofi waybar matugen-bin mission-center swaync fastfetch nano xarchiver ncdu openssh flatpak mpv qimgv better-control pavucontrol base-devel git cmake ninja udiskie btop playerctl fish arandr nwg-look nwg-displays nwg-clipman starship 

echo "installing drivers..."
paru -Syu --needed bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge networkmanager btrfs-progs gvfs gvfs-dnssd cliphist wl-clipboard ffmpeg 7zip jq poppler fd ripgrep ripdrag fzf zoxide resvg imagemagick libqalculate aubio libcava evolution-data-server

echo "installing themes and fonts..."
paru -Syu --needed tokyonight-gtk-theme-git adw-gtk-theme noto-fonts noto-fonts-emoji ttf-font-awesome nerd-fonts papirus-icon-theme bibata-cursor-theme-bin ttf-rubik-vf ttf-material-symbols-variable-git python-materialyoucolor ttf-roboto inter-font 

echo "packages installed"

# 2. symlink dotfiles using stow
echo "setting up dotfiles..."

if [ -d "$DOTDIR" ]; then
    
    # --- Part A: Handle ~/.config (from ~/dotfiles/config) ---
    if [ -d "$CONFIG_SRC" ]; then
        echo "🔗 processing configs..."
        mkdir -p "$HOME/.config"

        # Backup existing configs to avoid stow conflicts
        # This checks: if a folder exists in .config AND in your dotfiles, but isn't a link yet -> backup it
        for folder in "$CONFIG_SRC"/*; do
            name=$(basename "$folder")
            target="$HOME/.config/$name"
            if [ -d "$target" ] && [ ! -L "$target" ]; then
                echo "⚠️ backuping existing config: $target -> $target.backup"
                mv "$target" "$target.backup"
            fi
        done

        # Apply stow for configs
        # -d: source dir, -t: target dir, .: stow everything inside source
        stow -v -d "$CONFIG_SRC" -t "$HOME/.config" .
    else
        echo "ℹ️ directory $CONFIG_SRC not found, skipping config linking"
    fi

    # --- Part B: Handle Home files (from ~/dotfiles/home) ---
    if [ -d "$HOME_SRC" ]; then
        echo "🔗 processing home files..."
        
        # Apply stow for home files (like .zshrc, .bashrc)
        stow -v -d "$HOME_SRC" -t "$HOME" .
    else
        echo "ℹ️ directory $HOME_SRC not found, skipping home linking"
    fi

    echo "✅ dotfiles linked successfully"

else
    echo "❌ dotfiles folder not found at $DOTDIR, skipping linking"
fi

# 3. set up keyboard layouts
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo tee /etc/X11/xorg.conf.d/00-keyboard.conf > /dev/null <<EOF
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ua,ru"
        Option "XkbVariant" ""
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection
EOF

echo "keyboard layout configured"

# 4. change default shell to fish
echo "changing your default shell to fish"
chsh -s $(which fish) || echo "failed to change shell for user, do it yourself"
sudo chsh -s $(which fish) root || echo "failed to change shell for root, do it yourself"

# 5. add zsh plugins (optional, kept from original script)
if [ -d "$ZSH/custom/plugins" ]; then
  cd "$ZSH/custom/plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions || echo "zsh-autosuggestions already exists"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting || echo "zsh-syntax-highlighting already exists"
  echo "zsh plugins installed"
else
  # Removed the error message since you are using fish and might not have ZSH folder
  echo "skipping zsh plugins (folder not found)"
fi

echo "all done, restart your computer to apply changes"

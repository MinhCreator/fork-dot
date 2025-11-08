#!/bin/bash

set -e

DOTDIR="$HOME/dotfiles"

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

echo "starting to install packages, hold tight..."

# 0. symlink dotfiles
if [ -d "$DOTDIR" ]; then
  echo "linking dotfiles..."

  # ---------- link top-level dotfiles
  for file in "$DOTDIR"/.*; do
    name="$(basename "$file")"

    # skip . and ..
    [[ "$name" == "." || "$name" == ".." ]] && continue

    # skip .config
    [[ "$name" == ".config" ]] && continue

    target="$HOME/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "⚠️ $target already exists (not symlink), skipping"
      continue
    fi

    ln -sf "$file" "$target"
    echo "→ linked $name"
  done

  # ---------- link .config/*
  if [ -d "$DOTDIR/.config" ]; then
    mkdir -p "$HOME/.config"

    for file in "$DOTDIR/.config"/*; do
      name="$(basename "$file")"
      target="$HOME/.config/$name"

      if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "⚠️ $target exists (not symlink), skipping"
        continue
      fi

      ln -sf "$file" "$target"
      echo "→ linked .config/$name"
    done
  fi

  echo "✅ dotfiles linked"
else
  echo "❌ dotfiles folder not found at $DOTDIR, skipping"
fi

# 1. update system and install packages (paru must be installed!)
paru -Syu --needed --noconfirm matugen-bin ente-auth firefox alacritty thunar bspwm sxhkd hyprland hyprpaper hyprcursor hyprlock hypridle rofi polybar waybar dunst mission-center swaync neofetch visual-studio-code-bin vim neovim gamemode wine wine-mono portproton steam an-anime-game-launcher prismlauncher xarchiver openssh gvfs flatpak pamac mpv qimgv better-control pavucontrol discord ayugram-desktop-bin spotify spicetify-cli jdk8-openjdk jdk17-openjdk jdk21-openjdk base-devel git networkmanager btrfs-progs udiskie flameshot htop mc playerctl zsh arandr nwg-look nitrogen cava peaclock bluez blueman pipewire wireplumber pipewire-pulse pipewire-alsa xdg-desktop-portal xdg-desktop-portal-hyprland xwaylandvideobridge nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader kripton-theme-git tokyonight-gtk-theme-git tokyonight-gtk-theme-git ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd nerd-fonts papirus-icon-theme papirus-folders bibata-cursor-theme-bin
# install vencord (discord mod)
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

echo "packages installed"

# 2. set up keyboard layouts
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

# 3. change default shell to fish
echo "changing your default shell to fish"
chsh -s $(which fish) || echo "failed to change shell for user, do it yourself"
sudo chsh -s $(which fish) root || echo "failed to change shell for root, do it yourself"

# 4. add zsh plugins (requires $ZSH and oh-my-zsh)
if [ -d "$ZSH/custom/plugins" ]; then
  cd "$ZSH/custom/plugins"
  git clone https://github.com/zsh-users/zsh-autosuggestions || echo "zsh-autosuggestions already exists"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting || echo "zsh-syntax-highlighting already exists"
  echo "zsh plugins installed"
else
  echo "directory $ZSH/custom/plugins not found, skipping plugin installation"
fi

# 5. install osu!
if [ ! -d osu-winello ]; then
  git clone https://github.com/NelloKudo/osu-winello.git
fi
cd osu-winello
chmod +x ./osu-winello.sh
./osu-winello.sh

echo "all done, restart your computer to apply changes"

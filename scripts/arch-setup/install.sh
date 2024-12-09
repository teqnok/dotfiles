#!/sbin/bash
sudo pacman -Syu --noconfirm --needed stow

stow ../..

sudo pacman -S --needed wezterm jq fd fzf tree \
    fastfetch zsh tmux man-db less zoxide wget unzip neovim \
    tree-sitter-cli mpd mpv ncmpcpp lsd eza btop bat \
    brightnessctl bluez-utils sof-firmware \
    wlr-randr git go \
    vlc firefox ttf-jetbrains-mono-nerd hyprland hyprlock hyprpaper qt6ct rofi-wayland \
    dolphin qt6-wayland papirus-icon-theme flatpak plymouth breeze-plymouth plymouth-kcm
sudo nvim /etc/mkinitcpio.conf
# --
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
# just to be safe
nvim PKGBUILD
makepkg -si
# --

chsh -s $(which zsh)

#!/sbin/bash
sudo pacman -Syu --noconfirm --needed stow

stow ../..

sudo pacman -S --needed kitty jq fd fzf tree \
    fastfetch fish zsh tmux man-db less zoxide wget unzip neovim \
    tree-sitter-cli mpd mpv ncmpcpp lsd eza htop bat \
    brightnessctl bluez-utils sof-firmware sway waybar \
    wlr-randr networkmanager nm-applet dunst git go \
    vlc firefox ttf-jetbrains-mono-nerd hyprland hyprlock hyprpaper qt6ct rofi-wayland \
    dolphin qt6-wayland papirus-icon-theme flatpak
# --
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
# just to be safe
nvim PKGBUILD
makepkg -si
yay -Sy --noconfirm visual-studio-code-bin
# --

chsh -s $(which zsh)

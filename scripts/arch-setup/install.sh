while IFS= read -r line; do
    echo "Installing $line"
    sudo pacman -S --noconfirm --needed $line
done < PKGLIST

import os
from simple_term_menu import TerminalMenu

pkglists = {
    "LSP": ["rust", "rust-analyzer", "pyright", "python3", "lua-language-server"],
    "CLI": ["zsh", "stow", "lsd", "btop", "neovim", "zellij", "archinstall", "btrfs-progs", "zoxide", "unzip", "flatpak", "jq", "fd", "fzf", "bat"],
    "GUI": ["firefox", "wezterm", "ttf-jetbrains-mono-nerd", "waybar", "vlc", "mpv"],
    "KDE": ["plasma-meta", "papirus-icon-theme", "sof-firmware"],
}

def install_pkgs(pkglist: list[str]):
    os.system("sudo pacman -S --noconfirm --needed " + ' '.join(pkglist))

def get_preview(item):
    return ' | '.join(pkglists[item])

def show_install_menu():
    menu_items = list(pkglists.keys())
    terminal_menu = TerminalMenu(menu_items, title="Install Packages", preview_command=get_preview, multi_select=True)
    selected_indices = terminal_menu.show()

    if selected_indices:
        selected_pkgs = []
        for index in selected_indices: # pyright: ignore
            selected_pkgs.extend(pkglists[menu_items[index]])
        install_pkgs(selected_pkgs)
    else:
        print("no packages selected.")
def install_yay():
    if os.system("which yay > /dev/null") == 0:
        return
    os.system("git clone https://aur.archlinux.org/yay.git /tmp/yay")
    dir = os.getcwd()
    os.chdir("/tmp/yay")
    os.system("$EDITOR PKGBUILD")
    os.system("makepkg -si --noconfirm")
    os.system("cd .. && rm -rf yay")
    os.chdir(dir)
    print("yay installed successfully.")

def show_main_menu():
    main_menu_items = ["install packages", "change shell", "install yay", "exit"]
    terminal_menu = TerminalMenu(main_menu_items, title="main menu")
    while True:
        selected_index = terminal_menu.show()

        if selected_index == 0:
            show_install_menu()
        elif selected_index == 1:
            os.system("chsh -s $(which zsh)")
        elif selected_index == 2:
            install_yay()
        elif selected_index == 3:
            exit(0)

if __name__ == "__main__":
    show_main_menu()


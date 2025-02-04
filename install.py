import os
import click
from simple_term_menu import TerminalMenu

pkglists = {
    "LSP": ["rust", "rust-analyzer", "pyright", "python3", "lua-language-server"],
    "CLI": ["zsh", "stow", "lsd", "btop", "neovim", "zellij", "archinstall", "btrfs-progs","starship", "zoxide", "unzip", "flatpak", "jq", "fd", "fzf", "bat"],
    "GUI": ["firefox", "wezterm", "ttf-jetbrains-mono-nerd", "waybar", "vlc", "mpv"],
    "KDE": ["plasma-meta", "papirus-icon-theme", "sof-firmware"],
}
def check_exists(execs: list[str]) -> bool:
    return all(os.system(f"which {exec} > /dev/null") == 0 for exec in execs)
def use_tempdir(repo: str, cmds: list[str]):
    dir = os.getcwd()
    repo_name = repo.split('/')[-1].replace('.git', '')
    os.system(f"git clone {repo} /tmp/{repo_name}")
    os.chdir(f"/tmp/{repo_name}")
    try:
        for cmd in cmds:
            os.system(cmd)
    finally:
        os.system(f"cd .. && rm -rf {repo_name}")
        os.chdir(dir)

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
    use_tempdir(
        repo="https://aur.archlinux.org/yay.git",
        cmds=[
            "$EDITOR PKGBUILD",
            "makepkg -si --noconfirm",
        ]
    )

def install_kde():
    use_tempdir(
        repo="https://github.com/catppuccin/kde", 
        cmds=["./install.sh"]
    )

def install_dots():
    os.chdir("../..")
    os.system("stow .")
    os.system('nvim --headless "+Lazy! sync" +qa')

def show_main_menu():
    deps = ["stow","git"]
    if check_exists(deps) == False:
        print("err: missing one of (stow, git).")
        if click.confirm("install them and continue?", default=True):
            install_pkgs(deps)
        return
    main_menu_items = ["install packages", "change shell", "install yay", "install catppuccin/kde", "install dots","exit"]
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
            install_kde()
        elif selected_index == 4:
            install_dots()
        elif selected_index == 5:
            exit(0)

if __name__ == "__main__":
    show_main_menu()


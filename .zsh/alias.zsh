export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --prompt='=> ' --preview-window='border-sharp' --height=~40%"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'

alias c='clear'
alias ls="lsd"
alias e='exit'
alias nc='ncmpcpp'
alias upd="sudo pacman -Syu"
alias getpkg="sudo pacman -S"
alias delpkg="sudo pacman -R"
alias Delpkg="sudo pacman -Rns" 
alias catpkg="yay -Si"

function presudo() {
    BUFFER="sudo $BUFFER"
    CURSOR+=5
}
zle -N presudo

bindkey "^f" 'presudo'
function __get_package_list() {
    pacman -Sl | while read -r repo name version; do
            echo "$name $version | $repo"
    done
}
function findpkg() {
    action=$(echo -e "Cancel\nUpdate System\nUpdate Mirrors\nManage Packages" | fzf --prompt "Choose an action: " -m)

    case "$action" in
        "Update System")
            echo "Updating system..."
            sudo pacman -Syu --noconfirm
            ;;
        "Update Mirrors")
            echo "Updating mirrors..."
            sudo pacman -Sy
            ;;
        "Manage Packages")
            # Use reformat_pacman_list to display and select packages
            selected_packages=$(__get_package_list | fzf --multi --preview 'pacman -Si {1}' --prompt "Packages => ")
            trimmed=$(echo "$selected_packages" | awk '{print $1}' | tr '\n' ' ')
            if [[ -z "$selected_packages" ]]; then
                echo "No packages selected."
                return
            fi

            action=$(echo -e "Cancel\nInstall\nRemove\nReinstall" | fzf --prompt "Choose action for package(s) => " --header "Selected Packages: | $trimmed|" -m)

            case "$action" in
                "Install")
                    echo "Installing packages..."
                    echo "$trimmed" | xargs -r sudo pacman -S --noconfirm
                    ;;
                "Remove")
                    echo "Removing packages..."
                    echo "$trimmed" | xargs -r sudo pacman -R --noconfirm
                    ;;
                "Reinstall")
                    echo "Reinstalling packages..."
                    echo "$trimmed" | xargs -r sudo pacman -S --overwrite --noconfirm
                    ;;
                "Cancel")
                    echo "Operation cancelled."
                    ;;
                *)
                    echo "No action selected or invalid action."
                    ;;
            esac
            ;;
        "Cancel")
            echo "Operation cancelled."
            ;;
        *)
            echo "No action selected or invalid action."
            ;;
    esac
}
export PATH="$PATH:/home/teqnok/.dotnet/tools"

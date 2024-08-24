export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --prompt='=> ' --preview-window='border-sharp' --height=~20%"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
. "$HOME/.cargo/env"

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
function findpkg() {
    pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | while read -r pkg; do
    action=$(echo -e "Install\nRemove\nUpdate\nReinstall" | fzf --prompt "Choose action for $pkg:")

    case "$action" in
        "Install")
            echo "Installing $pkg..."
            sudo pacman -S "$pkg"
            ;;
        "Remove")
            echo "Removing $pkg..."
            sudo pacman -R "$pkg"
            ;;
        "Update")
            echo "Updating $pkg..."
            sudo pacman -Syu "$pkg"
            ;;
        "Reinstall")
            echo "Reinstalling $pkg..."
            sudo pacman -S --overwrite "$pkg"
            ;;
        *)
            echo "No action selected or invalid action."
            ;;
    esac
done
}

alias fdpkg=findpkg

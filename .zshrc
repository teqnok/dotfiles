ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then 
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

export STARSHIP_CONFIG=~/.zsh/starship.toml
eval "$(starship init zsh)"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

bindkey -v
bindkey '^[' vi-cmd-mode
bindkey '^p' hist_search_backward
bindkey '^n' hist_search_forward
bindkey -s '^[e' "nvim "
bindkey "^L" clear-screen
# Ctrl + Left/Right 
bindkey "^[[1;5D" forward-word
bindkey "^[[1;5C" backward-word
# Delete key (hacky)
bindkey "^[[3~" delete-char
bindkey "^[[3;2~" delete-word

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
KEYTIMEOUT=1

setopt appendhistory
setopt sharehistory
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':fzf-tab:*' popup-min-size 80 12
zstyle ':fzf-tab:*' fzf-command fzf
source ~/.zsh/alias.zsh

zstyle ':completion:*' format '%d'
zstyle :compinstall filename '/home/teqnok/.zshrc'
# this does... something
function terminal_title_preexec() {
    print -Pn -- "\e]2;${(q)1}\a"
}
function terminal_title_precmd() {
    print -Pn -- '\e]2;%~\a'
}
add-zsh-hook -Uz precmd terminal_title_precmd
add-zsh-hook -Uz preexec terminal_title_preexec
autoload -Uz compinit
compinit
export EDITOR=nvim

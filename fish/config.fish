alias .="nvim ."
alias csv="visidata"
alias e="eza -l -a --no-user"
alias gc="gcloud"
alias lg="lazygit"
alias ld="lazydocker"
alias t="tmux"
alias vim="nvim"
alias nvims='NVIM_APPNAME="nvim-starter" nvim'
alias w="z"

set fish_greeting
set EDITOR nvim
set VISUAL nvim
set -gx XDG_CONFIG_HOME ~/.config
set -x ESCDELAY 0
export EDITOR
export VISUAL

# fzf
fzf --fish | source

# zoxide
zoxide init fish | source

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

#
#   Simple aliases
#
alias tmux="tmux -2"
alias vim="nvim"
alias txp="tmuxp"
alias txl="tmuxp load"

set -xg ERL_AFLAGS "-kernel shell_history enabled"
set -xg PATH ~/.local/bin/ $PATH
set -xg EDITOR "/usr/bin/nvim"

# Opam
if test -n "$OPAM_SWITCH_PREFIX"
    eval (opam env)
end

# VI mode
fish_vi_key_bindings

# Remove greeting
set fish_greeting

# RTX
rtx activate -s fish | source

# IEx options
set -xg ERL_AFLAGS "-kernel shell_history enabled"
set -xg IEX_WITH_WERL 1

# Load host-specific file
set -xg HOSTNAME (hostname)
set -xg FISH_HOST_CONFIG_FILE "$__fish_config_dir/conf.host/$HOSTNAME.fish"
source $FISH_HOST_CONFIG_FILE

# Set up zoxide
zoxide init fish | source

# Set up shiny new tools!
alias cat="bat --paging=never"
alias grep="rg"
alias psql="pgcli"
alias cd="z"
alias find="fd"

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/xavier.nunn/.ghcup/bin # ghcup-env

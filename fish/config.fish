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

# VI mode
fish_vi_key_bindings

# Remove greeting
set fish_greeting

# IEx options
set -xg ERL_AFLAGS "-kernel shell_history enabled"
set -xg IEX_WITH_WERL 1

# Load host-specific file
set -xg HOSTNAME (hostname)
set -xg FISH_HOST_CONFIG_FILE "$__fish_config_dir/conf.host/$HOSTNAME.fish"
source $FISH_HOST_CONFIG_FILE

# mise-en-place
mise activate -s fish | source

# Set up zoxide
zoxide init fish | source

# Set up shiny new tools!
alias cat="bat --paging=never"
alias grep="rg"
alias find="fd"
alias cd="z"

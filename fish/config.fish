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
if type -q "bat" then
    alias cat="bat --paging=never"
end
if type -q "rg" then
    alias grep="rg"
end
if type -q "fd" then
    alias find="fd"
end
if type -q "z" then 
    alias cd="z"
end
if type -q "tmux" then
    alias tmux="tmux -2"
end
if type -q "nvim" then
    alias vim="nvim"
end
if type -q "tmuxp" then
    alias txp="tmuxp"
    alias txl="tmuxp load"
end

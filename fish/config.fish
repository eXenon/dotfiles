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

# Load host-specific file
set -xg HOSTNAME (hostname)
set -xg FISH_HOST_CONFIG_FILE "$__fish_config_dir/conf.host/$HOSTNAME.fish"
source $FISH_HOST_CONFIG_FILE

# Opam
if test -n "$OPAM_SWITCH_PREFIX"
    eval (opam env)
end

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

# Autoload NVM on directory change
function __check_rvm --on-variable PWD --description 'Autoload .nvmrc file'
  status --is-command-substitution; and return
  if test -e .nvmrc
    set node_v (cat .nvmrc)
    echo "Loading $node_v..."
    nvm
  end
end

# VI mode
fish_vi_key_bindings

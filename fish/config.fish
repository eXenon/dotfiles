#
#   Simple aliases
#
alias tmux="tmux -2"
alias vim="nvim"
alias txp="tmuxp"
alias txl="tmuxp load"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cba/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/home/cba/google-cloud-sdk/path.fish.inc'; else; . '/home/cba/google-cloud-sdk/path.fish.inc'; end; end

set -xg PATH ~/.local/bin/ $PATH

#
#   Simple aliases
#
function tmux
	/usr/bin/tmux -2 $argv
end

function vim
  nvim $argv
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cba/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/home/cba/google-cloud-sdk/path.fish.inc'; else; . '/home/cba/google-cloud-sdk/path.fish.inc'; end; end

set -xg PATH ~/.local/bin/ $PATH

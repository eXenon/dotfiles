if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval (/opt/homebrew/bin/brew shellenv)

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

source /opt/homebrew/Cellar/fzf/0.34.0/shell/key-bindings.fish


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/xavier.nunn/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/xavier.nunn/Downloads/google-cloud-sdk/path.fish.inc'; end

# Opam init
source /Users/xavier.nunn/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

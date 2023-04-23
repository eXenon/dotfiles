set -g fish_term24bit 1
set -gx KBFS /home/exenon/keybase/
set -gx CHALET 51.38.236.94
set -gx TODOASSIST 51.68.228.135
set -gx DOTFILES /home/exenon/dotfiles/
fish_add_path --global $HOME/.cargo/bin

function tx
  tmux attach -t txmain; or tmux new -s txmain
end

function tx-takeover
  tmux detach -a
end

function loadavg
  uptime | grep -o '[0-9]\+\.[0-9]\+' | head -n1
end

function diskusg
  df / | tail -n1 | sed "s/  */ /g" | cut -d' ' -f 5 | cut -d'%' -f1
end

function reload
  source ~/.config/fish/config.fish
end


function __tabby_working_directory_reporting --on-event fish_prompt --description "Function to allow the tabby terminal to know where it's at"
    echo -en "\e]1337;CurrentDir=$PWD\x7"
end

# Opam
source /home/exenon/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

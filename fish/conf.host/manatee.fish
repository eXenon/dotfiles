set -gx KBFS /home/exenon/keybase/
set -gx CHALET 5.196.1.178
set -gx DOTFILES /home/exenon/dotfiles/

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
